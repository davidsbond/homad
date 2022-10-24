resource "boundary_user" "david" {
  name        = "david"
  account_ids = [boundary_account_password.david.id]
  scope_id    = boundary_scope.org.id
}
