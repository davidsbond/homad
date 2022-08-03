#!/usr/bin/env bash
# This script is used to write the contents of a postgres database to blob storage for backups.

set -e

DATABASES=$(psql -t -c "SELECT datname FROM pg_database WHERE datname NOT IN ('template0', 'template1', 'postgres')")

mc alias set minio "$MINIO_HOST" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY"

for DATABASE in $DATABASES; do
  BUCKET_PATH=minio/postgres-backups/"$DATABASE".sql.gz
  pg_dump "$DATABASE" | gzip | mc pipe "$BUCKET_PATH"
done
