#!/bin/sh
# Docker entrypoint script.

set -e

# Wait for Postgres to become available.
until psql -h postgres_db -U "postgres" -c '\q' 2>/dev/null; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done


cd assets && npm install
cd ..

export PORT=80

mix deps.get

# Potentially Set up the database
mix ecto.create
mix ecto.migrate

echo "\nTesting the installation..."

if [ "$TRAVIS_TEST" = "true" ]
then
#    MIX_ENV=test mix coveralls.travis
    mix test
else
    mix test
    mix phx.routes
    mix phx.server
fi

