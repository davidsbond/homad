resource "vault_generic_secret" "cloudflare" {
  path = "cloudflare/auth"
  data_json = jsonencode({
    api_key = var.cloudflare_api_key,
    email   = var.cloudflare_email
  })
}

resource "vault_generic_secret" "pihole" {
  path = "pihole/auth"
  data_json = jsonencode({
    password = var.pihole_password
  })
}

resource "vault_generic_secret" "postgres_root" {
  path = "postgres/root"
  data_json = jsonencode({
    user     = var.postgres_root_user,
    password = var.postgres_root_password
  })
}
