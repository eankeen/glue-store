#!/usr/bin/env bash
eval "$GLUE_COMMANDS_BOOTSTRAP"
bootstrap || exit

# glue useAction(do-tool-prettier-init.sh)
# glue useAction(do-tool-eslint-init.sh)

util.get_action "do-tool-prettier-init.sh"
source "$REPLY"

util.get_action "do-tool-eslint-init.sh"
source "$REPLY"

unbootstrap
