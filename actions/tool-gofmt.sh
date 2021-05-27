#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'gofmt'

util.shopt -s dotglob
util.shopt -s nullglob

gofmt -s -l -w ./**/*.go

unbootstrap
