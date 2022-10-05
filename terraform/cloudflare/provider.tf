terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.25.0"
    }
  }
}

provider "cloudflare" {
  email   = var.email
  api_key = var.api_key
}
