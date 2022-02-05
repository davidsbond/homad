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

variable "nomad_client_ips" {
  type        = set(string)
  description = "The IP addresses of the Nomad client nodes"
}
