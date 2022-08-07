resource "minio_s3_bucket" "postgres_backups" {
  bucket = "postgres-backups"
}

resource "minio_s3_bucket" "nomad_backups" {
  bucket = "nomad-backups"
}
