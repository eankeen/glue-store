#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

# glue useConfig(golangci-lint)
util.ln_config "golangci-lint/.golangci.yaml" ".golangci.yaml"

ensure.cmd 'golangci-lint'

golangci-lint run --enable-all ./...

unbootstrap
