# shellcheck shell=sh

# note 1
# the variables GLUE_ACTIONS_DIR
# GLUE_COMMANDS_DIR, and GLUE_CONFIG_DIR,
# will all be incorrect when sourcing this file. I don't
# change them because I don't use them on the first pass
# of any of the bootstrap files

# shellcheck disable=SC2016
printf "%s" '
if [[ $GLUE_IS_AUTO == yes ]]; then
	if [ -f "$GLUE_COMMANDS_DIR"/../util/bootstrap.sh ]; then
		source "$GLUE_COMMANDS_DIR"/../util/bootstrap.sh
	else
		# see note 1
		[[ -f $GLUE_COMMANDS_DIR/util/bootstrap.sh ]] && source "$GLUE_COMMANDS_DIR/util/bootstrap.sh"
	fi
else
	if [[ -f $GLUE_COMMANDS_DIR/util/bootstrap.sh ]]; then
		source "$GLUE_COMMANDS_DIR/util/bootstrap.sh"
	else
		# see note 1
		[[ -f $GLUE_COMMANDS_DIR/auto/util/bootstrap.sh ]] && source "$GLUE_COMMANDS_DIR/auto/util/bootstrap.sh"
	fi
fi
'
