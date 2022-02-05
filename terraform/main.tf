terraform {
  backend "consul" {
    address = "192.168.0.21:8500"
    scheme  = "http"
    path    = "homad/terraform"
  }
}

module "vault" {
  source  = "./vault"
  address = var.vault_url
  token   = var.vault_token
}

module "nomad" {
  source  = "./nomad"
  address = var.nomad_url
}

module "consul" {
  source  = "./consul"
  address = var.consul_url
}

module "cloudflare" {
  source  = "./cloudflare"
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key

  # DNS record configuration
  nomad_client_ips = var.nomad_client_ips
}
