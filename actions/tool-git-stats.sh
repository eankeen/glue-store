#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	bootstrap.generated 'tool-git-stats'; (
		git-stats --global-activity >| "$GENERATED_DIR/calendar"
	); unbootstrap.generated
}

action "$@"
unbootstrap
