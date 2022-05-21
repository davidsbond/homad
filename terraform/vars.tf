variable "vault_url" {
  type        = string
  description = "The URL of the Vault server"
}

variable "vault_token" {
  type        = string
  description = "The Vault token to use for authentication"
}

variable "nomad_url" {
  type        = string
  description = "The URL of the Nomad server"
}

variable "consul_url" {
  type        = string
  description = "The URL of the Consul server"
}

variable "cloudflare_email" {
  type        = string
  description = "The email address to use for authenticating with Cloudflare"
}

variable "cloudflare_api_key" {
  type        = string
  description = "The API key to use for authenticating with Cloudflare"
}

variable "tailscale_api_key" {
  type        = string
  description = "The API key to use for authenticating with the Tailscale API"
}

variable "tailscale_tailnet" {
  type        = string
  description = "The Tailnet to use"
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
