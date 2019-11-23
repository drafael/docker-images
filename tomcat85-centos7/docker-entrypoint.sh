#!/usr/bin/env bash

set -e

if [ "$(id -u)" = '0' ]; then              # current user is root
    chown -R tomcat:tomcat .               # fix permissions on mounted volumes (if any)
	exec gosu tomcat "$BASH_SOURCE" "$@"   # step-down from root
fi

exec "$@"
