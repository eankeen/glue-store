#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	ensure.cmd 'cz'

	# glue useConfig(tool-cz)
	util.run_exitcode util.ln_config 'tool-cz/.cz.json' '.cz.json'

	REPLY="$exitCode"
}

action "$@"
unbootstrap
