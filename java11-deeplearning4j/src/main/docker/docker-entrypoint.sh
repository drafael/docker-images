#!/usr/bin/env sh

set -e

if [ "$(id -u)" = '0' ]; then                                 # current user is root
    chown -R "${USER_NAME}":"${USER_NAME}" "${APP_DIR}"       # fix permissions on mounted volumes (if any)
    exec gosu "${USER_NAME}" "$BASH_SOURCE" "$@"              # step-down from root
fi

exec "$@"
