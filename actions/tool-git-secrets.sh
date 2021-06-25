#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	git-secrets --install --force
}

action "$@"
unbootstrap
