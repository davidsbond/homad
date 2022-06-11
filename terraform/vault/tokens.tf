resource "vault_token" "boundary" {
  renewable = true
  ttl       = "24h"
  no_parent = true
  period    = "24h"
  policies  = [vault_policy.boundary_credential_store.name]
}
