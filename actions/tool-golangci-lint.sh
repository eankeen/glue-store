#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

# glue useConfig(golangci-lint)
util.ln_config "golangci-lint/.golangci.yaml" ".golangci.yaml"

ensure.cmd 'golangci-lint'

util.shopt -s dotglob
util.shopt -s nullglob

golangci-lint run --enable-all ./...

unbootstrap
