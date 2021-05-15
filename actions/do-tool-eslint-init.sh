#!/usr/bin/env bash
eval "$GLUE_ACTIONS_BOOTSTRAP"
bootstrap

# glue requireConfig(.eslintrc.js)

util.ln_config ".eslintrc.js"
