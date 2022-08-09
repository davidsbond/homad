resource "vault_token_auth_backend_role" "nomad_cluster" {
  role_name              = "nomad-cluster"
  disallowed_policies    = ["nomad-server"]
  token_explicit_max_ttl = 0
  orphan                 = true
  token_period           = 259200
  renewable              = true
  allowed_policies = [
    vault_policy.cloudflare_reader.name,
    vault_policy.postgres_reader.name,
    vault_policy.pihole_reader.name,
    vault_policy.grafana_reader.name,
    vault_policy.boundary_reader.name,
    vault_policy.minio_reader.name,
    vault_policy.home_assistant_reader.name,
  ]
}
