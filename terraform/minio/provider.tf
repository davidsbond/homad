terraform {
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "1.12.0"
    }
  }
}

provider "minio" {
  minio_server     = var.minio_server
  minio_access_key = var.minio_access_key
  minio_secret_key = var.minio_secret_key
  minio_ssl        = true
}
