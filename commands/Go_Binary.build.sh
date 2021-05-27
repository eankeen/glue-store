#!/usr/bin/env bash

# glue useAction(tool-golangci-lint.sh)

go build -ldflags "-X main.version=1.0.1" main.go
