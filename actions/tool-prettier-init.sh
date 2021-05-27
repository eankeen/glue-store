#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

# glue useConfig(.prettierrc.js)

util.get_config '.prettierrc.js'

unbootstrap
