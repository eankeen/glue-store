#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

ensure.cmd 'bats'

action() {
	local -a dirs=()

	(
		if [ -d pkg ]; then
			cd pkg || error.cd_failed
			dirs=(../test ../tests)
		else
			dirs=(test tests)
		fi

		for dir in "${dirs[@]}"; do
			if [ ! -d "$dir" ]; then
				continue
			fi

			bats --recursive --output "." "$dir"
		done
	)
}

action "$@"
unbootstrap
