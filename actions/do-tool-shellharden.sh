#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'shellharden'

util.shopt -s nullglob
util.shopt -s dotglob

# shellharden --suggest -- ./**/*.{sh,bash}
# shellharden --check -- ./**/*.{sh,bash}

unbootstrap
