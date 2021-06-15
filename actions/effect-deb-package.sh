#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	:
}

action "$@"
unbootstrap
