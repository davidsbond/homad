resource "vault_generic_secret" "boundary_password" {
  path = "boundary/david"
  data_json = jsonencode({
    password = var.boundary_password
  })
}

resource "vault_generic_secret" "boundary_config" {
  path = "boundary/config"
  data_json = jsonencode({
    config = file("${path.module}/files/boundary/boundary.hcl")
  })
}
