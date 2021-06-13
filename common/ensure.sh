#!/usr/bin/env bash

ensure.cmd() {
	local cmd="$1"

	ensure.nonZero 'cmd' "$cmd"

	if ! command -v "$cmd" &>/dev/null; then
		die "Command '$cmd' not found"
	fi
}

# TODO: replace many ensure.nonZero with ensure.args

ensure.args() {
	local fnName="$1"
	local argNums="$2"
	shift; shift;

	ensure.nonZero 'fnName' "$fnName"
	ensure.nonZero 'argNums' "$argNums"

	local argNum
	for argNum in $argNums; do
		if [ -z "${!argNum}" ]; then
		# if [ -z "${@:$argNum:1}" ]; then
			echo "Context: '$0'" >&2
			echo "Context \${BASH_SOURCE[*]}: ${BASH_SOURCE[*]}" >&2
			log.error "ensure.args: Function '$fnName' has missing arguments" >&2
			exit 1
		fi
	done
}

ensure.nonZero() {
	local varName="$1"
	local varValue="$2"

	if [ -z "$varName" ] || [ $# -ne 2 ]; then
		die "ensure.nonZero: Incorrect arguments passed to 'ensure.nonZero'"
	fi

	if [ -z "$varValue" ]; then
		die "ensure.nonZero: Variable '$varName' must be non zero"
	fi
}

ensure.file() {
	local fileName="$1"

	ensure.nonZero 'fileName' "$fileName"

	if [ ! -f "$fileName" ]; then
		die "ensure.file: File '$fileName' does not exist"
	fi
}

ensure.dir() {
	local dirName="$1"

	ensure.nonZero 'dirName' "$dirName"

	if [ ! -f "$dirName" ]; then
		die "ensure.file: File '$dirName' does not exist"
	fi
}

ensure.git_working_tree_dirty() {
	log.ensure 'git_working_tree_clean'

	if ! is.git_working_tree_dirty; then
		local cmd
		if is.wet_release; then
			cmd="die"
		else
			cmd="log.warn"
		fi

		"$cmd" 'Git working directory is clean. Please commit your changes and try again'
	fi
}

ensure.git_working_tree_clean() {
	log.info 'ensure: git_working_tree_clean'

	if is.git_working_tree_dirty; then
		local cmd
		if is.wet_release; then
			cmd="die"
		else
			cmd="log.warn"
		fi

		"$cmd" 'Git working directory is dirty. Changes to tracked files should have been made'
	fi
}

ensure.git_common_history() {
	log.info 'ensure: git_common_history'

	local remote="${1-origin/main}"
	local branch="${2:-main}"

	if ! git merge-base --is-ancestor "$remote" "$branch"; then
		local cmd
		if is.wet_release; then
			cmd="die"
		else
			cmd="log.warn"
		fi

		# main NOT is the same or has new additional commits on top of origin/main"
		"$cmd" "Detected that your 'main' branch and it's remote have diverged. Won't initiate release process until histories are shared"
	fi

}

# TODO: ensure there are no tags that exists that are greater than it
ensure.git_version_tag_validity() {
	log.info 'ensure: git_version_tag_validity'

	local version="$1"

	ensure.nonZero 'version' "$version"

	if [ -n "$(git tag -l "v$version")" ]; then
		die 'Version already exists in a Git tag'
	fi
}

ensure.git_repository_initialized() {
	log.info 'ensure: git_repository_initialized'

	if [ ! -d .git ] || [ ! -f .git/HEAD ]; then
		die 'A Git repository must exist in this directory'
	fi

	if ! git log -1 &>/dev/null; then
		die 'Your git repository must have at least one commit'
	fi
}

ensure.git_only_version_changes() {
	log.info 'ensure: git_only_version_changes'

	# We filter 'diff' until only changed lines remains. We then
	# strip all lines that have 'version'

	# shellcheck disable=SC2143
	if [ -n "$(
		git diff --unified=0 --cached  \
		| grep '^[+-]' \
		| grep -Ev '^(--- a/|\+\+\+ b/)' \
		| grep -iv version
	)" ] || [ -n "$(
		git diff --unified=0  \
		| grep '^[+-]' \
		| grep -Ev '^(--- a/|\+\+\+ b/)' \
		| grep -iv version
	)" ]; then
		# If there is anything left in the string, it means that lines besides
		# those with 'version' in them have been changed
		local cmd
		if is.wet_release; then
			cmd="die"
		else
			cmd="log.warn"
		fi

		"$cmd" "Changes other than version increments have been made. Please rebuild (if applicable) and commit those changes before running this command again"
	fi
}

ensure.version_is_only_major_minor_patch() {
	log.info 'ensure: version_is_only_major_minor_patch'

	local version="$1"

	ensure.nonZero 'version' "$version"

	case "$version" in
	*-*|*+*|*_*)
		die 'Version string contains more than just major, minor, and patch numbers'
	esac
}

ensure.confirm_wet_release() {
	read -rei 'Do wet release? '
	if [[ "$REPLY" != *y* ]]; then
		die
	fi
}

ensure.exit_code_success() {
	REPLY=

	local exitCode="$1"

	ensure.nonZero 'exitCode' "$exitCode"

	if [ "$exitCode" -ne 0 ]; then
		local cmd
		if is.wet_release; then
			cmd="die"
		else
			cmd="log.warn"
		fi

		"$cmd" 'A previous step did not exit successfully'
	fi
}
