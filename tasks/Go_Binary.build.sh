#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

task() {
	go build -ldflags "-X main.version=1.0.1" main.go
}


task "$@"
unbootstrap
