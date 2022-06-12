resource "boundary_credential_store_vault" "homad" {
  name     = "homad"
  address  = var.vault_address
  token    = var.vault_token
  scope_id = boundary_scope.homad.id
}
