#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'nimpretty'

util.shopt -s dotglob
util.shopt -s globstar
util.shopt -u nullglob

nimpretty --maxLinelen:100 ./**/*.nim

unbootstrap
