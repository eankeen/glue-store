#!/usr/bin/env bash
eval "$GLUE_ACTIONS_BOOTSTRAP"
bootstrap

# glue requireConfig(.prettierrc.js)

util.get_config -q '.prettierrc.js'
