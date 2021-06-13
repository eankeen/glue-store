#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

# docker
# node-prune

unbootstrap
