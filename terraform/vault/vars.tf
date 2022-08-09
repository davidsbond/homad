variable "address" {
  type        = string
  description = "The URL of the Vault server"
}

variable "token" {
  type        = string
  description = "The Vault token to use for authentication"
}

variable "cloudflare_email" {
  type        = string
  description = "The email address to use for authenticating with Cloudflare"
}

variable "cloudflare_api_key" {
  type        = string
  description = "The API key to use for authenticating with Cloudflare"
}

variable "pihole_password" {
  type        = string
  description = "The password for the pihole web UI"
}

variable "postgres_root_user" {
  type        = string
  description = "The root username for postgres"
}

variable "postgres_root_password" {
  type        = string
  description = "The root password for postgres"
}

variable "postgres_home_assistant_user" {
  type        = string
  description = "The username in postgres for the home_assistant database"
}

variable "postgres_home_assistant_password" {
  type        = string
  description = "The password in postgres for the home_assistant database"
}

variable "postgres_boundary_user" {
  type        = string
  description = "The username in postgres for the boundary database"
}

variable "postgres_boundary_password" {
  type        = string
  description = "The password in postgres for the boundary database"
}

variable "grafana_email" {
  type        = string
  description = "The email address to use for authenticating with grafana"
}

variable "grafana_password" {
  type        = string
  description = "The password to use for authenticating with grafana"
}

variable "boundary_password" {
  type        = string
  description = "The password for the boundary administrator user"
}

variable "minio_root_user" {
  type        = string
  description = "The root user for accessing minio"
}

variable "minio_root_password" {
  type        = string
  description = "The password for the minio root user"
}

variable "home_assistant_access_token" {
  type        = string
  description = "The access token for home-assistant"
}
