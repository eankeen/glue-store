#!/usr/bin/env/bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'deadcode'

deadcode -test .

unbootstrap
