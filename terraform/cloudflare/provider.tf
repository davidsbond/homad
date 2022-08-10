terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.21.0"
    }
  }
}

provider "cloudflare" {
  email   = var.email
  api_key = var.api_key
}
