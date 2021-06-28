#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

task() {
	# glue useAction(tool-git-secrets.sh)
	util.get_action 'tool-git-secrets.sh'
	source "$REPLY"
	local exitCode="$REPLY"

	REPLY="$exitCode"
}

task "$@"
unbootstrap
