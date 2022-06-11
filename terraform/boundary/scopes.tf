resource "boundary_scope" "org" {
  scope_id    = "global"
  name        = "organization"
  description = "Organization scope"

  auto_create_admin_role   = false
  auto_create_default_role = false
}

resource "boundary_scope" "homad" {
  name                     = "homad"
  scope_id                 = boundary_scope.org.id
  auto_create_admin_role   = false
  auto_create_default_role = false
}
