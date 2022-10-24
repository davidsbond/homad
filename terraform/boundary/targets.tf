resource "boundary_target" "homelab" {
  name         = "homelab"
  type         = "tcp"
  default_port = "22"
  scope_id     = boundary_scope.homad.id
  host_source_ids = [
    boundary_host_set_static.homelab.id,
  ]
  brokered_credential_source_ids = [
    boundary_credential_library_vault.homad.id
  ]
}
