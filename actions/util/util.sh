# shellcheck shell=bash

util:get_working_dir() {
	while [ ! -f "glue.sh" ] && [ "$PWD" != / ]; do
		cd ..
	done

	if [ "$PWD" = / ]; then
		die 'No glue config file found in current or parent paths'
	fi

	printf "%s" "$PWD"
}

util:get_file() {
	local dir="$1"
	local configFile="$2"

	REPLY=
	case "$1" in
		actions|commands|configs) :;;
		*) log:error "get_file for dir '$1' is not supported"
	esac

	if [ -f "$GLUE_WD/.glue/$dir/$configFile" ]; then
		REPLY="$GLUE_WD/.glue/$dir/$configFile"
	elif [ -f "$GLUE_WD/.glue/$dir/auto/$configFile" ]; then
		REPLY="$GLUE_WD/.glue/$dir/auto/$configFile"
	else
		die "File '$configFile' not found in either '$GLUE_WD/.glue/$dir' or '$GLUE_WD/.glue/$dir/auto'. This is likely an issue with your Glue store"
	fi
}

util:get_action() {
	util:get_file "actions" "$1"
	printf "%s" "$REPLY"
}

util_get_command() {
	util:get_file "commands" "$1"
	printf "%s" "$REPLY"
}

util:get_config() {
	util:get_file "configs" "$1"
	printf "%s" "$REPLY"
}
