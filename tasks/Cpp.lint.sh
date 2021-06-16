#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

task() {
	:
	# CDPATH= gcc -Weverything -ferror-limit=0 -ftemplate-backtrace-limit=0

	# diagtool
}

task "$@"
unbootstrap
