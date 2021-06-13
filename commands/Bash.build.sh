#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

task() {
	util.extract_version_string
	local newVersion="$REPLY"

	custom.bump_version_hook() {
		# glue useAction(util-Bash-version-bump.sh)
		util.get_action 'util-Bash-version-bump.sh'
		source "$REPLY" "$newVersion"
	}
	hook.bump_version "$newVersion"

	# glue useAction(util-Bash-generate-bins.sh)
	util.get_action 'util-Bash-generate-bins.sh'
	source "$REPLY"
}

task "$@"
unbootstrap
