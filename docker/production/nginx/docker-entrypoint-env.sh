#!/bin/sh
set -e

find /app/public \
  -type f \
  -name '*.js' \
  -exec sed -i "s+%%REACT_APP_API_URL%%+${REACT_APP_API_URL:?}+g" '{}' \;

exec /docker-entrypoint.sh "$@"