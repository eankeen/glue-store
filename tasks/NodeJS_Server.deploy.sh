#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

task() {
	:
	# docker
	# node-prune
}

task "$@"
unbootstrap
