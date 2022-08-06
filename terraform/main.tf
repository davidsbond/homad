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

  # Cloudflare secrets
  cloudflare_api_key = var.cloudflare_api_key
  cloudflare_email   = var.cloudflare_email

  # Pihole secrets
  pihole_password = var.pihole_password

  # Postgres secrets
  postgres_root_user               = var.postgres_root_user
  postgres_root_password           = var.postgres_root_password
  postgres_home_assistant_user     = module.postgres.home_assistant_username
  postgres_home_assistant_password = module.postgres.home_assistant_password
  postgres_boundary_user           = module.postgres.boundary_username
  postgres_boundary_password       = module.postgres.boundary_password

  # Grafana secrets
  grafana_email    = var.grafana_email
  grafana_password = var.grafana_password

  # Boundary secrets
  boundary_password = module.boundary.boundary_password

  # Minio secrets
  minio_root_user     = var.minio_root_user
  minio_root_password = var.minio_root_password
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
  source  = "./cloudflare"
  api_key = var.cloudflare_api_key
  email   = var.cloudflare_email

  # IP addresses that become records
  nomad_client_ips = module.tailscale.homelab_clients
  nas_ip           = module.tailscale.nas
}

module "postgres" {
  source   = "./postgres"
  host     = var.postgres_host
  username = var.postgres_root_user
  password = var.postgres_root_password
}

module "boundary" {
  source            = "./boundary"
  addr              = var.boundary_url
  token             = var.boundary_token
  vault_address     = var.vault_url
  vault_token       = module.vault.boundary_vault_token
  recovery_kms_file = var.boundary_recovery_file
  homelab_servers   = module.tailscale.homelab_servers
}

module "minio" {
  source           = "./minio"
  minio_access_key = var.minio_root_user
  minio_secret_key = var.minio_root_password
  minio_server     = var.minio_url
}

module "grafana" {
  source   = "./grafana"
  url      = var.grafana_url
  email    = var.grafana_email
  password = var.grafana_password
}
