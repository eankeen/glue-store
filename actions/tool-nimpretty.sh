#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'nimpretty'

util.shopt -s dotglob
util.shopt -s globstar
util.shopt -u nullglob

# TODO: editorconfig for -indent, maxLineLen
nimpretty ./**/*.nim

unbootstrap
