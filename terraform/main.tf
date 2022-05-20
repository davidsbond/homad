terraform {
  backend "consul" {
    address = "consul.homelab.dsb.dev"
    scheme  = "https"
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

module "tailscale" {
  source  = "./tailscale"
  api_key = var.tailscale_api_key
  tailnet = var.tailscale_tailnet
}

module "cloudflare" {
  source           = "./cloudflare"
  api_key          = var.cloudflare_api_key
  email            = var.cloudflare_email
  nomad_client_ips = module.tailscale.homelab_clients
}
