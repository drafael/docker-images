#!/bin/bash
#
# docker-entrypoint for docker-solr

set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi

if [ "$(id -u)" = '0' ]; then             # current user is root
    chown -R solr:solr .                  # fix permissions on mounted volumes
	exec gosu solr "$BASH_SOURCE" "$@"    # step-down from root
fi

if [[ -v SOLR_PORT ]] && ! grep -E -q '^[0-9]+$' <<<"${SOLR_PORT:-}"; then
  SOLR_PORT=8983
  export SOLR_PORT
fi

# when invoked with e.g.: docker run solr -help
if [ "${1:0:1}" = '-' ]; then
    set -- solr-foreground "$@"
fi

# execute command passed in as arguments.
# The Dockerfile has specified the PATH to include
# /opt/solr/bin (for Solr) and /opt/docker-solr/scripts (for our scripts
# like solr-foreground, solr-create, solr-precreate, solr-demo).
# Note: if you specify "solr", you'll typically want to add -f to run it in
# the foreground.
exec "$@"
