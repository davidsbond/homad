resource "vault_policy" "nomad_server" {
  name   = "nomad-server"
  policy = file("${path.module}/policies/nomad-server.hcl")
}

resource "vault_policy" "cloudflare_reader" {
  name   = "cloudflare-reader"
  policy = file("${path.module}/policies/cloudflare-reader.hcl")
}

resource "vault_policy" "postgres_reader" {
  name   = "postgres-reader"
  policy = file("${path.module}/policies/postgres-reader.hcl")
}

resource "vault_policy" "pihole_reader" {
  name   = "pihole-reader"
  policy = file("${path.module}/policies/pihole-reader.hcl")
}

resource "vault_policy" "grafana_reader" {
  name   = "grafana-reader"
  policy = file("${path.module}/policies/grafana-reader.hcl")
}
