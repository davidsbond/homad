resource "vault_policy" "nomad_server" {
  name   = "nomad-server"
  policy = file("${path.module}/policies/nomad-server-policy.hcl")
}

resource "vault_policy" "cloudflare_reader" {
  name   = "cloudflare-reader"
  policy = file("${path.module}/policies/cloudflare-reader-policy.hcl")
}

resource "vault_policy" "grafana_reader" {
  name   = "grafana-reader"
  policy = file("${path.module}/policies/grafana-reader-policy.hcl")
}
