#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	ensure.cmd 'go'

	go get ./...
}

action "$@"
unbootstrap
