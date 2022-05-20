variable "api_key" {
  type        = string
  description = "The API key to use for authenticating with the Tailscale API"
}

variable "tailnet" {
  type        = string
  description = "The Tailnet to use"
}
