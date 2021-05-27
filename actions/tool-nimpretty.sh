#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'nimpretty'

util.shopt -u dotglob
util.shopt -u nullglob

# TODO: editorconfig for -indent, maxLineLen
nimpretty ./**/*.nim

unbootstrap
