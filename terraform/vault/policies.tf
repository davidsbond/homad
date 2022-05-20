resource "vault_policy" "nomad_server" {
  name   = "nomad-server"
  policy = file("${path.module}/policies/nomad-server-policy.hcl")
}

resource "vault_policy" "cloudflare_reader" {
  name   = "cloudflare-reader"
  policy = file("${path.module}/policies/cloudflare-reader-policy.hcl")
}

resource "vault_policy" "postgres_reader" {
  name   = "postgres-reader"
  policy = file("${path.module}/policies/postgres-reader-policy.hcl")
}
