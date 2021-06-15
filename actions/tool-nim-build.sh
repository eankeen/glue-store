#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	ensure.cmd 'nimble'

	projectName=
	for nimbleFile in *.nimble; do
		projectName=${nimbleFile%%.*}
		break
	done

	ensure.nonZero 'projectName' "$projectName"

	nimble build "$projectName"
}

action "$@"
unbootstrap
