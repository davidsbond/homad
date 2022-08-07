#!/usr/bin/env bash
# This script is used to write the local nomad configuration to blob storage for backups.

set -e

mc alias set minio "$MINIO_HOST" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY"

BUCKET_PATH=minio/nomad-backups/"$(hostname)".hcl.gz
gzip /etc/nomad.d/nomad.hcl | mc pipe "$BUCKET_PATH"
