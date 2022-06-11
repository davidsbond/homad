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
