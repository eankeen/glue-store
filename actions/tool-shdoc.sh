#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap || exit

action() {
	ensure.cmd 'shdoc'

	util.shopt -s dotglob
	util.shopt -s globstar
	util.shopt -s nullglob

	generated.in 'tool-shdoc'
	(
		if [ ! -d pkg ]; then
			error.non_conforming "'./pkg' directory does not exist"
		fi
		cd pkg || error.cd_failed

		for file in ./**/*.{sh,bash}; do
			local output="$GENERATED_DIR/$file"
			mkdir -p "${output%/*}"
			output="${output%.*}"
			output="$output.md"
			shdoc < "$file" > "$output"
		done
	)
	generated.out
}

action "$@"
unbootstrap
