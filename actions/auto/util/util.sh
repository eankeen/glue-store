# shellcheck shell=bash

util_get_working_dir() {
	while [ ! -f "glue.sh" ] && [ "$PWD" != / ]; do
		cd ..
	done

	if [ "$PWD" = / ]; then
		die 'No glue config file found in current or parent paths'
	fi

	printf "%s" "$PWD"
}

util:get_dir_abstract() {
	local typeDir="$1"
	local configFile="$2"

	REPLY=
	if [ "$GLUE_IS_AUTO" = yes ]; then
		if [ -f "$typeDir/../util/$configFile" ]; then
			REPLY="$typeDir/../util/$configFile"
		elif [ -f "$typeDir/util/$configFile" ]; then
			REPLY="$typeDir/util/$configFile"
		else
			die "Config file '$configFile' not found. This is an issue with the glue store"
		fi
	else
		if [ -f "$typeDir/util/$configFile" ]; then
			REPLY="$typeDir/util/$configFile"
		elif [ -f "$typeDir/auto/util/$configFile" ]; then
			REPLY="$typeDir/auto/util/$configFile"
		else
			die "Config file '$configFile' not found. This is an issue with the glue store"
		fi
	fi
}

util:get_action() {
	local actionFile="$1"

	util:get_dir_abstract "$GLUE_ACTIONS_DIR" "$actionFile"
	printf "%s" "$REPLY"
}

util_get_command() {
	local commandFile="$1"

	util:get_dir_abstract "$GLUE_COMMANDS_DIR" "$commandFile"
	printf "%s" "$REPLY"
}

util:get_config() {
	local configFile="$1"

	util:get_dir_abstract "$GLUE_CONFIGS_DIR" "$configFile"
	printf "%s" "$REPLY"
}
