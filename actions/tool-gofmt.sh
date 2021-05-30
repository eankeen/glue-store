#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'gofmt'

go list -f '{{.Dir}}' ./... \
	| xargs gofmt -s -l -w

unbootstrap
