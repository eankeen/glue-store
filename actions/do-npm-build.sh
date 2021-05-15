#!/usr/bin/env bash

eval "$GLUE_ACTIONS_BOOTSTRAP"
bootstrap_init
bootstrap

# glue requireConfigs(prettier.config.js)

prettierConfig="$(util_get_config "prettier.config.js")"
ln -sfT "$prettierConfig" "$GLUE_CONFIGS_DIR/prettier.config.js"
