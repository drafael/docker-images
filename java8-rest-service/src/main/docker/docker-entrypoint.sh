#!/bin/sh

set -e

if [ "$(id -u)" = '0' ]; then                             # current user is root
    chown -R "${USER_NAME}":"${USER_NAME}" "${APP_DIR}"   # fix permissions on mounted volumes (if any)
    exec su-exec "${USER_NAME}" "$0" "$@"                 # step-down from root
fi

exec "$@"
