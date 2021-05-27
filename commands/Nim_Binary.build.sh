#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

# glue useAction(do-nim-format.sh)
util.get_action "do-nim-format.sh"
source "$REPLY"

# glue useAction(do-nim-lint.sh)
util.get_action "do-nim-lint.sh"
source "$REPLY"

# glue useAction(do-nim-build.sh)
util.get_action "do-nim-build.sh"
source "$REPLY"
