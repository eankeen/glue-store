#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	ensure.cmd 'hadolint'

	local exitCode=0

	# TODO: function run and set exit code
	if hadolint ./**/Dockerfile; then
		exitCode=$?
	else
		exitCode=$?
	fi

	REPLY="$exitCode"
}

action "$@"
unbootstrap
