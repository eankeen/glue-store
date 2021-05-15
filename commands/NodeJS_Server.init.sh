#!/usr/bin/env bash
eval "$GLUE_COMMANDS_BOOTSTRAP"
bootstrap

# glue requireAction(do-tool-prettier-init.sh)
# glue requireAction(do-tool-eslint-init.sh)

util.get_action -q "do-tool-prettier-init.sh"
source "$REPLY"

# util.get_action -q "do-tool-eslint-init.sh"
# source "$REPLY"
