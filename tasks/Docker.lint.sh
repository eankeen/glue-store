#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

task() {
	# glue useAction(tool-hadolint.sh)
	util.get_action 'tool-hadolint.sh'
	source "$REPLY"
	local exitOne="$REPLY"

	# glue useAction(tool-dockerfilelint.sh)
	util.get_action 'tool-dockerfilelint.sh'
	source "$REPLY"
	local exitOne="$REPLY"

	REPLY="$exitOne"
}

task "$@"
unbootstrap
