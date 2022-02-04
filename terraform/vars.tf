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
