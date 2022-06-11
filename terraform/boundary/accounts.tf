resource "random_password" "david" {
  special = false
  length  = 16
}

resource "boundary_account" "david" {
  name           = "david"
  type           = "password"
  login_name     = "david"
  password       = random_password.david.result
  auth_method_id = boundary_auth_method.password.id
}
