variable "addr" {
  type        = string
  description = "The URL of the boundary instance"
}

variable "token" {
  type        = string
  description = "The token to use for boundary authentication"
}

variable "recovery_kms_file" {
  type        = string
  description = "The recovery file data for boundary authentication"
}

variable "homelab_servers" {
  type        = set(string)
  description = "The IP addresses of the homelab servers"
}

variable "vault_address" {
  type        = string
  description = "The URL of the Vault server"
}

variable "vault_token" {
  type        = string
  description = "The Vault token to use for authentication"
}
