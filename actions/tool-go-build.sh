#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	ensure.cmd 'go'

	go build ./...
}

action "$@"
unbootstrap
