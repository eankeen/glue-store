# shellcheck shell=sh

# The following is eval'ed as 'eval "$GLUE_COMMANDS_BOOTSTRAP"'
# in 'commands/{,auto/}*'

# Although all 'commands' are executed rather than sourced,
# it won't hurt to make the top-level check
if [ ! "$GLUE_COMMANDS_BOOTSTRAP_DID" = yes ]; then
	GLUE_COMMANDS_BOOTSTRAP_DID=yes

	if [ -z "$GLUE_WD" ]; then
		echo "Context: '$0'" >&2
		echo "Bootstrap Error: \$GLUE_WD is empty. Exiting" >&2
		exit 1
	fi

	if [ -f "$GLUE_WD/.glue/commands/auto/util/bootstrap.sh" ]; then
		. "$GLUE_WD/.glue/commands/auto/util/bootstrap.sh"
	elif [ -f "$GLUE_WD/.glue/commands/util/bootstrap.sh" ]; then
		. "$GLUE_WD/.glue/commands/util/bootstrap.sh"
	else
		echo "Context: '$0'" >&2
		echo "Bootstrap Error: Secondary stage bootstrap file found. Exiting" >&2
		exit 1
	fi
fi
