#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	ensure.cmd 'dockerfilelint'

	if dockerfilelint ./**/Dockerfile; then
		exitCode=$?
	else
		exitCode=$?
	fi

	REPLY="$exitCode"
}

action "$@"
unbootstrap
