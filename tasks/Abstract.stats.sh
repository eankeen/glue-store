#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

task() {
	# glue useAction(tool-git-cal.sh)
	util.get_action 'tool-git-cal.sh'
	source "$REPLY"
	local exitCode="$REPLY"

	REPLY="$exitCode"
}

task "$@"
unbootstrap
