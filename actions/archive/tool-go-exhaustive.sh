#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'exhaustive'

exhaustive -fix ./...

unbootstrap
