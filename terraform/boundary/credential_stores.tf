resource "boundary_credential_store_vault" "homad" {
  name     = "homad"
  address  = var.vault_address
  token    = var.vault_token
  scope_id = boundary_scope.homad.id
}

resource "boundary_credential_library_vault" "homad" {
  name                = "vault"
  credential_store_id = boundary_credential_store_vault.homad.id
  path                = "boundary/homad"
  http_method         = "GET"
}
