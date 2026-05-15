#!/bin/sh
set -eu

psql \
  --username "$POSTGRES_USER" \
  --dbname postgres \
  --set metabase_db_name="$METABASE_DB_NAME" \
  --set metabase_db_user="$METABASE_DB_USER" \
  --set metabase_db_password="$METABASE_DB_PASSWORD" <<'EOSQL'
SELECT format('CREATE ROLE %I LOGIN PASSWORD %L', :'metabase_db_user', :'metabase_db_password')
WHERE NOT EXISTS (
  SELECT 1
  FROM pg_catalog.pg_roles
  WHERE rolname = :'metabase_db_user'
) \gexec

SELECT format('CREATE DATABASE %I OWNER %I', :'metabase_db_name', :'metabase_db_user')
WHERE NOT EXISTS (
  SELECT 1
  FROM pg_database
  WHERE datname = :'metabase_db_name'
) \gexec
EOSQL
