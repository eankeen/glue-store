#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

task() {
	declare -g RELEASE_STATUS=dry
	for arg; do
		case "$arg" in
			--wet)
				# shellcheck disable=SC2034
				RELEASE_STATUS=wet
		esac
	done

	if is.wet_release; then
		ensure.confirm_wet_release
	else
		log.info "Running pre-release process in dry mode"
	fi
	ensure.cmd 'git'
	ensure.cmd 'gh'
	ensure.file 'glue-auto.toml'

	## 1
	ensure.git_repository_initialized
	ensure.git_only_version_changes
	ensure.git_common_history

	## 2
	# Build docs
	util.get_command 'Bash.docs.sh'
	source "$REPLY"
	ensure.exit_code_success "$REPLY"

	# Lint
	util.get_command 'Bash.lint.sh'
	source "$REPLY"
	ensure.exit_code_success "$REPLY"

	# Build
	util.get_command 'Bash.build.sh'
	source "$REPLY"
	ensure.exit_code_success "$REPLY"

	# Test
	util.get_command 'Bash.test.sh'
	source "$REPLY"
	ensure.exit_code_success "$REPLY"

	## 3
	ensure.git_only_version_changes

	## 4
	local newVersion=
	if is.wet_release; then
		# Running 'build' ensures this is correct
		toml.get_key 'version' 'glue-auto.toml'
		util.prompt_new_version "$REPLY"
		newVersion="$REPLY"

		ensure.nonZero 'newVersion' "$newVersion"
		ensure.version_is_only_major_minor_patch "$newVersion"
		ensure.git_version_tag_validity "$newVersion"
	else
		toml.get_key 'version' 'glue-auto.toml'
		newVersion="$REPLY"

		ensure.nonZero 'newVersion' "$newVersion"
	fi

	custom.bump_version_hook() {
		# glue useAction(util-Bash-version-bump.sh)
		util.get_action 'util-Bash-version-bump.sh'
		source "$REPLY" "$newVersion"
	}
	hook.bump_version "$newVersion"

	## 5
	ensure.git_only_version_changes

	## 6
	# glue useAction(tool-conventional-changelog.sh)
	util.get_action 'tool-conventional-changelog.sh'
	source "$REPLY" "$newVersion"
	local currentChangelog="$REPLY"

	ensure.nonZero 'currentChangelog' "$currentChangelog"
	ensure.file "$currentChangelog"

	## 7
	if is.wet_release; then
		git add -A
		git commit -m "chore(release): v$newVersion"
		git tag -a "v$newVersion" -m "Release $newVersion" HEAD
		git push --follow-tags origin HEAD

		local -a args=()
		if [ -f "$currentChangelog" ]; then
			args+=('-F' "$currentChangelog")
		else
			# '-n' is required for non-interactivity
			args+=('-n' '')
			log.warn 'CHANGELOG.md file not found. Creating empty notes file for release'
		fi

		# Remote Release
		gh release create "v$newVersion" --target main --title "v$newVersion" "${args[@]}"
	else
		log.info "Skipping Git taging and GitHub artifact release"
	fi

	## 8

	## 9
	# # glue useAction(result-pacman-package.sh)
	# util.get_action 'result-pacman-package.sh'
	# source "$REPLY"
}

task "$@"
unbootstrap
