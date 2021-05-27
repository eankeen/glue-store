#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'ineffassign'

ineffassign -fix ./...

unbootstrap
