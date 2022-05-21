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
