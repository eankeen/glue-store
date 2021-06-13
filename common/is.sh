# shellcheck shell=bash

# @description Checks if the Git working tree is dirty. This check also pertains to untracked files
is.git_working_tree_dirty() {
	if [ -n "$(git status --porcelain)" ]; then
		return 0
	else
		return 1
	fi
}

# must be set to 'wet' to not be dry, which so
# that it defaults to 'dry' on empty
is.dry_release() {
	if [ "$RELEASE_STATUS" != 'wet' ]; then
		return 0
	else
		return 1
	fi
}

is.wet_release() {
	if [ "$RELEASE_STATUS" = 'wet' ]; then
		return 0
	else
		return 1
	fi
}
