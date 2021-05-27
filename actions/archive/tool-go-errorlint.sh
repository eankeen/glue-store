#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'go-errorlint'

go-errorlint -fix ./...

unbootstrap
