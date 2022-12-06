terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.13.6"
    }
  }
}

provider "tailscale" {
  api_key = var.api_key
  tailnet = var.tailnet
}
