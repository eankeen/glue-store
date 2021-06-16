#!/usr/bin/env bash
set -eo pipefail
shopt -s extglob nullglob globstar

# @file lint.sh
# @brief This file lints the Glue store, checking for common mistakes or inaccuracies
# @description Everything is quite inefficient, but it works. It could work faster if
# more files were passed in per command (rather than using 'for' loop) and by
# testing ignored lint cases in constant time
# @exitcode 1 At least one lint error
# @exitcode 2 Discontinuity within lint code integer sequence

util:is_ignored_line() {
	local lastMatchedLine="$1"
	local file="$2"

	# shellcheck disable=SC1007
	local currentIgnoreFile= currentIgnoreLine=
	local -i haveRead=0
	while IFS= read -r line; do
		haveRead=$((haveRead+1))

		if ((haveRead == 1)); then
			currentIgnoreFile="$line"
		fi

		if ((haveRead == 2)); then
			currentIgnoreLine="$line"
		fi

		if ((haveRead == 3)); then
			haveRead=$((0))

			if [[ $currentIgnoreFile == "$file" && $currentIgnoreLine == "$lastMatchedLine" ]]; then
				return 0
			fi
		fi
	done < "$ignoreFile"



	return 1
}

util:get_n() {
	if [ "${1::1}" = - ]; then
		lastMatched="$(tac "$2" | sed "${1/#-/}q;d")"
	else
		lastMatched="$(sed "$1q;d" "$2")"
	fi

	printf '%s' "$lastMatched"
}

util:print_lint() {
	exitCode=2

	# This assumes a particular transgression is per-line.
	# This makes things easier as grep will match line by line
	while IFS= read -r lastMatchedLine; do
		lastMatchedLine=$(sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' <<< "$lastMatchedLine")
		if util:is_ignored_line "$lastMatchedLine" "$file"; then
			continue
		fi

		local error="Error (code $1)"
		local line="Line"
		local message="Message"
		if [[ ! -v NO_COLOR && $TERM != dumb ]]; then
			printf -v error "\033[0;31m%s\033[0m" "$error"
			printf -v line "\033[1;33m%s\033[0m" "$line"
			printf -v message "\033[1;33m%s\033[0m" "$message"
		fi

		echo "$error: $file"
		echo "  -> $line: '$lastMatchedLine'"
		echo "  -> $message: '$2'"
		echo
	done <<< "$lastMatched"

}

# shellcheck disable=SC2016
main() {
	declare -gi exitCode=0
	declare -g lastMatched=
	declare -g file
	declare -gr ignoreFile="./scripts/lint-ignore"

	# Hack because last line is cutoff
	cat >> "$ignoreFile" <<< $'\n'

	for file in ./{actions,tasks,util}/?*.sh; do
		if lastMatched="$(grep -P "(?<!ensure\.)cd[ \t]+" "$file")"; then
			util:print_lint 112 "Use 'ensure.cd' instead of 'cd'"
		fi
		:
	done

	for file in ./{actions,tasks}/?*.sh; do
		if [ "$(util:get_n 1 "$file")" != "#!/usr/bin/env bash" ]; then
			util:print_lint 101 'First line must begin with proper shebang'
		fi

		if [ "$(util:get_n 2 "$file")" != 'eval "$GLUE_BOOTSTRAP"' ]; then
			util:print_lint 102 'Second line must have eval'
		fi

		if [ "$(util:get_n 3 "$file")" != 'bootstrap' ]; then
			util:print_lint 103 'Third line must have bootstrap'
		fi

		if [ "$(util:get_n -1 "$file")" != 'unbootstrap' ]; then
			util:print_lint 106 "Second to last line must have 'unbootstrap'"
		fi

		if lastMatched="$(grep -E "REPLY=(\"\"|'')?$" "$file")"; then
			util:print_lint 109 "Do not set REPLY to empty string. This is already done in bootstrap()"
		fi

		if lastMatched="$(grep "\(||\|&&\)" "$file")"; then
			util:print_lint 110 "Do not use '||' or '&&', as they they will not work as intended with 'set -e' enabled"
		fi
	done

	for file in ./actions/?*.sh; do
		if [ "$(util:get_n 5 "$file")" != 'action() {' ]; then
			util:print_lint 104 "Fifth line in task file must have an 'action()' function"
		fi

		if [ "$(util:get_n -2 "$file")" != 'action "$@"' ]; then
			util:print_lint 107 "Third to last line must have 'action \"\$@\"'"
		fi

		if [ "$(util:get_n -4 "$file")" != '}' ]; then
			util:print_lint 111 "Fifth to last line must have '}'"
		fi
	done

	for file in ./tasks/?*.sh; do
		if [ "$(util:get_n 5 "$file")" != 'task() {' ]; then
			util:print_lint 105 "Fifth line in task file must have an 'task()' function"
		fi

		if [ "$(util:get_n -2 "$file")" != 'task "$@"' ]; then
			util:print_lint 108 "Third to last line must have 'task \"\$@\"'"
		fi
	done

	# Ensure no lint codes are skipped or repeated
	# Codes start at '101'
	local -i numCount=101
	# shellcheck disable=SC2013
	for num in $(grep -Eo 'util:print_lint 1[0-9]+' ./scripts/lint.sh | cut -d\  -f2 | sort -n); do
		if ((num != numCount)); then
			echo "Error: Abnormality in lint numbers around '$num'"
			echo "  -> Expected: $numCount; Received: $num"
			exitCode=3

			# Reset to known good number
			numCount=$((num))
		fi

		numCount=$((numCount+1))
	done
	echo "Latest Num: $num"

	return "$exitCode"
}

main "$@"
