# shellcheck shell=sh

trap sigint INT
sigint() {
	die 'Received SIGINT'
}

die() {
	log_error "${*-'die: '}. Exiting"
	exit 1
}

log_info() {
	printf "\033[0;34m%s\033[0m\n" "Info: $*"
}

log_warn() {
	printf "\033[1;33m%s\033[0m\n" "Warn: $*" >&2
}

log_error() {
	printf "\033[0;31m%s\033[0m\n" "Error: $*" >&2
}

util_get_working_dir() {
	while [ ! -f "glue.sh" ] && [ "$PWD" != / ]; do
		cd ..
	done

	if [ "$PWD" = / ]; then
		die 'No glue config file found in current or parent paths'
	fi

	printf "%s" "$PWD"
}

util_get_config() {
	configFile="$1"

	# if an override exists (above the 'auto' directory), use that
	if [ -f "$(dirname "$configDir")/$configFile" ]; then
		printf "%s" "$configDir/$configFile"
	elif [ -f "$configDir/$configFile" ]; then
		printf "%s" "$configDir/$configFile"
	else
		die 'No config file found. This is an issue with the glue store'
	fi
}
