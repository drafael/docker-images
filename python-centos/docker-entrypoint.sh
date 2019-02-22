#!/usr/bin/env bash

set -e

if [ "$(id -u)" = '0' ]; then             # current user is root
  chown -R python:python $VENV_DIR        # fix permissions on mounted volumes (if any)
  exec gosu python "$BASH_SOURCE" "$@"    # step-down from root
fi

if [ -f "$VENV_DIR/bin/activate" ]; then
  source "$VENV_DIR/bin/activate"
fi

exec "$@"
