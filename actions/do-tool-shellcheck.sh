#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

util.shopt -s nullglob
util.shopt -s dotglob

shellcheck --check-sourced -- ./**/*.{sh,bash}

unbootstrap
