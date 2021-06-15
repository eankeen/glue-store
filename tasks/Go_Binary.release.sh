#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

task() {
	:
}


task "$@"
unbootstrap
