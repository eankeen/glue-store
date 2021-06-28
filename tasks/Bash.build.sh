#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

task() {
	util.extract_version_string
	local version="$REPLY"

	hook.util.update_version_strings.bump_version() {
		local version="$1"

		# glue useAction(task-Bash-version-bump.sh)
		util.get_action 'task-Bash-version-bump.sh'
		source "$REPLY" "$version"
	}

	util.update_version_strings "$version"

	# glue useAction(task-Bash-generate-bins.sh)
	util.get_action 'task-Bash-generate-bins.sh'
	source "$REPLY"

	# With 'set -e' enabled, the previous commands
	# were successful; otherwise, we wouldn't be here
	REPLY=0
}

task "$@"
unbootstrap
