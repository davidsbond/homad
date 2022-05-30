terraform {
  required_providers {
    tailscale = {
      source  = "davidsbond/tailscale"
      version = "0.10.2"
    }
  }
}

provider "tailscale" {
  api_key = var.api_key
  tailnet = var.tailnet
}
