#!/usr/bin/env bash

# glue requireAction(do-npm-build.sh)

eval "$GLUE_COMMANDS_BOOTSTRAP"
bootstrap_init
bootstrap

util:get_action "do-npm-build.sh"
