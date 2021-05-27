#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'aligncheck'
ensure.cmd 'structcheck'
ensure.cmd 'varcheck'

aligncheck ./...

structcheck -t ./...

varcheck ./...

unbootstrap
