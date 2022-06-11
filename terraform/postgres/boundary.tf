resource "random_password" "boundary" {
  special = false
  length  = 16
}

resource "postgresql_role" "boundary" {
  name     = "boundary"
  login    = true
  password = random_password.boundary.result
}

resource "postgresql_database" "boundary" {
  name  = "boundary"
  owner = postgresql_role.boundary.name
}
