#!/usr/bin/env bash

generated.in() {
	local dir="$1"

	ensure.nonZero 'dir' "$dir"

	# shellcheck disable=SC2034
	declare -g GENERATED_DIR="$GLUE_WD/.glue/generated/$dir"
	declare -g GENERATED_DIR_PRETTY="$dir"

	if [ -d "$GLUE_WD/.glue/generated/$dir" ]; then
		rm -rf "$GLUE_WD/.glue/generated/$dir"
	fi
	mkdir -p "$GLUE_WD/.glue/generated/$dir"

	if [[ "${LANG,,?}" == *utf?(-)8 ]]; then
		echo "■■■■■■ 🢂  IN GENERATED: '$GENERATED_DIR_PRETTY'"
	else
		echo "=> IN GENERATED: '$GENERATED_DIR_PRETTY'"
	fi
}

generated.out() {
	if [[ "${LANG,,?}" == *utf?(-)8 ]]; then
		echo "■■■■■■ 🢀  OUT GENERATED: '$GENERATED_DIR_PRETTY'"
	else
		echo "<= OUT GENERATED: '$GENERATED_DIR_PRETTY'"
	fi
}
