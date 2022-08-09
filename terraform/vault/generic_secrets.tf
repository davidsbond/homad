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

resource "vault_generic_secret" "grafana" {
  path = "grafana/admin"
  data_json = jsonencode({
    email    = var.grafana_email
    password = var.grafana_password
  })
}

resource "vault_generic_secret" "minio" {
  path = "minio/root"
  data_json = jsonencode({
    user     = var.minio_root_user
    password = var.minio_root_password
  })
}

resource "vault_generic_secret" "home_assistant" {
  path = "home-assistant/auth"
  data_json = jsonencode({
    access_token = var.home_assistant_access_token
  })
}
