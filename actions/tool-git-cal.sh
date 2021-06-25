#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	bootstrap.generated 'tool-git-cal'; (
		git-cal >| "$GENERATED_DIR/calendar"
	); unbootstrap.generated
}

action "$@"
unbootstrap
