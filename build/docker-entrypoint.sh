#!/usr/bin/env bash

# Exit immediately on non-zero return codes.
set -e

# Use the `filebeat` command if only options were given.
if [ "${1:0:1}" = '-' ]; then
	set -- filebeat "$@"
fi

# Handle running the filebeat command.
if [ "$1" = 'filebeat' ]; then

	# Run via filebeat user.
	set -- gosu $FILEBEAT_USER "$@"
fi

# Execute the command.
exec "$@"
