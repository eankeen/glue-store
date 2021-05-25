#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

if [ -f "$GLUE_WD/package-lock.json" ]; then
	npm build
elif [ -f "$GLUE_WD/yarn.lock" ]; then
	yarn build
elif [ -f "$GLUE_WD/pnpm-lock.yaml" ]; then
	pnpm build
fi

unbootstrap
