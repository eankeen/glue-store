#!/usr/bin/env bash

hook.bump_version() {
	local newVersion="$1"

	ensure.nonZero 'newVersion' "$newVersion"
	ensure.file 'glue-auto.toml'

	if grep -q version glue-auto.toml; then
		sed -i -e "s|\(version[ \t]*=[ \t]*[\"']\).*\([\"']\)|\1${newVersion}\2|g" glue-auto.toml
	else
		echo "version = '$newVersion'" > glue-auto.toml
	fi


	if command -v custom.bump_version_hook &>/dev/null; then
		if ! custom.bump_version_hook; then
			die "Hook 'custom.bump_version_hook' did not complete successfully"
		fi
	fi
	unset custom.bump_version_hook
}
