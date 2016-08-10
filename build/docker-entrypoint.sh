#!/usr/bin/env bash

# Exit immediately on non-zero return codes.
set -e

# Use the `filebeat` command if only options were given.
if [ "${1:0:1}" = '-' ]; then
	set -- filebeat "$@"
fi

# Run as user `filebeat` if the command is `filebeat`.
if [ "$1" = 'filebeat' ]; then
	set -- gosu filebeat "$@"
fi

# Execute the command.
exec "$@"
