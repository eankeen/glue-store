# shellcheck shell=bash

die() {
	log:error "${*-'die: '}. Exiting"
	exit 1
}

# TODO: check for color term
log:info() {
	printf "\033[0;34m%s\033[0m\n" "Info: $*"
}

log:warn() {
	printf "\033[1;33m%s\033[0m\n" "Warn: $*" >&2
}

log:error() {
	printf "\033[0;31m%s\033[0m\n" "Error: $*" >&2
}
