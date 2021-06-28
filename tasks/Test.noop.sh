#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

task() {
	# glue useAction(task-Test-noop.sh)
	echo "Task 'Test.noop.sh' executed"
}

task "$@"
unbootstrap
