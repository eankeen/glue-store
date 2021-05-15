#!/usr/bin/env bash

eval "$GLUE_COMMANDS_BOOTSTRAP"
bootstrap
bootstrap_init

# glue requireAction(do-npm-build.sh)

# source "$GLUE_ACTIONS_DIR/do-npm-build.sh"

log:info "Content"

# util:get_action prettier.config.js
