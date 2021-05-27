#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'exportloopref'

exportloopref -fix ./...

unbootstrap
