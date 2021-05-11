# shellcheck shell=bash

bootstrap() {
	shopt -q nullglob
	local shoptExitStatus="$?"
	shopt -s nullglob

	# paths of all the files to source
	local -a filesToSource=()

	local utilDirAuto
	if [[ $GLUE_IS_AUTO = yes ]]; then
		utilDirAuto="$GLUE_ACTIONS_DIR/util"
	else
		utilDirAuto="$GLUE_ACTIONS_DIR/auto/util"
	fi

	local utilDirOverride
	if [[ $GLUE_IS_AUTO = yes ]]; then
		utilDirOverride="$GLUE_ACTIONS_DIR/../util"
	else
		utilDirOverride="$GLUE_ACTIONS_DIR/util"
	fi

	# Add file in 'util' to filesToSource, ensuring priority of 'override' scripts

	local file possibleFileBasename
	for file in "$utilDirOverride"/*?.sh; do
		echo "added: $file"
		filesToSource+=("$file")
	done

	for possibleFile in "$utilDirAuto"/*?.sh; do
		possibleFileBasename="${possibleFile##*/}"

		if [[ $possibleFileBasename == 'bootstrap.sh' ]]; then
			continue
		fi

		# loop over exiting files that we're going to source
		# and ensure 'possibleFile' is not already there
		local alreadyThere=no
		for file in "${filesToSource[@]}"; do
			fileBasename="${file##*/}"

			# if the file is not included (which means it's not
			# already covered by 'override'), add it
			if [[ $fileBasename == "$possibleFileBasename" ]]; then
				alreadyThere=yes
			fi
		done

		if [[ $alreadyThere == no ]]; then
			filesToSource+=("$possibleFile")
		fi
	done

	(( shoptExitStatus != 0 )) && shopt -u nullglob

	for file in "${filesToSource[@]}"; do
		source "$file"
	done
}
