#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

task() {
	# glue useAction(tool-nim-format.sh)
	util.get_action "tool-nim-format.sh"
	source "$REPLY"

	# glue useAction(tool-nim-lint.sh)
	util.get_action "tool-nim-lint.sh"
	source "$REPLY"

	# glue useAction(tool-nim-build.sh)
	util.get_action "tool-nim-build.sh"
	source "$REPLY"
}

task "$@"
unbootstrap
