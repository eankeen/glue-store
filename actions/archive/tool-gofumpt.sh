#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'gofumpt'

gofumpt -l -w ./...

unbootstrap
