#!/usr/bin/env bash
eval "$GLUE_ACTIONS_BOOTSTRAP"
bootstrap || exit

# glue useConfig(.eslintrc.js)

util.ln_config ".eslintrc.js"

unbootstrap
