# shellcheck shell=bash

# If a file was not found in the glue store, print an
# error, showing the directories searched, and any
# useful tips (beacuset this error will be bound to crop up)
error.file_not_found_in_glue_store() {
	log.error "Could not find '$1' in '$GLUE_WD/.glue/$2' or '$GLUE_WD/.glue/$2/auto'"
	echo "    -> Did you spell the filename in the file annotation 'requireAction(...)' properly?"
	exit 1
}
