# shellcheck shell=sh

# The following is eval'ed as 'eval "$GLUE_ACTIONS_BOOTSTRAP"'
# in 'actions/{,auto/}*'

# Check if  we have already bootstraped. This is useful if an
# action file is sourced
if [ ! "$GLUE_ACTIONS_BOOTSTRAP_DID" = yes ]; then
	GLUE_ACTIONS_BOOTSTRAP_DID=yes

	if [ -z "$GLUE_WD" ]; then
		echo "Context: '$0'" >&2
		echo "Bootstrap Error: \$GLUE_WD is empty. Exiting" >&2
		exit 1
	fi

	if [ -f "$GLUE_WD/.glue/actions/auto/util/bootstrap.sh" ]; then
		. "$GLUE_WD/.glue/actions/auto/util/bootstrap.sh"
	elif [ -f "$GLUE_WD/.glue/actions/util/bootstrap.sh" ]; then
		. "$GLUE_WD/.glue/actions/util/bootstrap.sh"
	else
		echo "Context: '$0'" >&2
		echo "Bootstrap Error: Secondary stage bootstrap file found. Exiting" >&2
		exit 1
	fi
fi
