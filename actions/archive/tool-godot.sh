#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd "$GOPATH/bin/godot"

"$GOPATH/bin/godot" -c -scope all -w ./...
