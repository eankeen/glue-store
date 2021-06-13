#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

task() {
	# glue useAction(tool-bats.sh)
	util.get_action 'tool-bats.sh'
	source "$REPLY"
}

task "$@"
unbootstrap
