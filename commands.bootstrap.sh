# shellcheck shell=sh

# The following is eval'ed as 'eval "$GLUE_COMMANDS_BOOTSTRAP"'
# in 'commands/{,auto/}*'

if [ -f "$GLUE_WD/.glue/commands/auto/util/bootstrap.sh" ]; then
	. "$GLUE_WD/.glue/commands/auto/util/bootstrap.sh"
elif [ -f "$GLUE_WD/.glue/commands/util/bootstrap.sh" ]; then
	. "$GLUE_WD/.glue/commands/util/bootstrap.sh"
else
	echo "Error: No bootstrap file found. This is an error with the glue store. Exiting"
	exit 1
fi
