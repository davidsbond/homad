variable "host" {
  type        = string
  description = "The host of the Postgres instance"
}

variable "user" {
  type        = string
  description = "The username to use when authenticating with the Postgres instance"
}

variable "password" {
  type        = string
  description = "The password to use when authenticating with the Postgres instance"
}
