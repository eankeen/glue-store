#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

# glue useAction(do-tool-prettier-init.sh)
# glue useAction(do-tool-eslint-init.sh)

util.get_action "do-tool-prettier-init.sh"
source "$REPLY"

util.get_action "do-tool-eslint-init.sh"
source "$REPLY"

unbootstrap
