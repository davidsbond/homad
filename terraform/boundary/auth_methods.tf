resource "boundary_auth_method" "password" {
  name     = "password"
  type     = "password"
  scope_id = boundary_scope.org.id
}
