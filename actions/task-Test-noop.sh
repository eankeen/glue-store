#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	echo "Action 'task-Test-noop.sh' executed"
}

action "$@"
unbootstrap
