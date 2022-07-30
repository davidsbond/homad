variable "minio_server" {
  type        = string
  description = "The URL of the minio API"
}

variable "minio_access_key" {
  type        = string
  description = "The access key to use for authentication"
}

variable "minio_secret_key" {
  type        = string
  description = "The secret key to use for authentication"
}
