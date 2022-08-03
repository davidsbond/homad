resource "minio_s3_bucket" "postgres_backups" {
  bucket = "postgres-backups"
}
