resource "vault_generic_secret" "postgres_root" {
  path = "postgres/root"
  data_json = jsonencode({
    user     = var.postgres_root_user,
    password = var.postgres_root_password
  })
}

resource "vault_generic_secret" "postgres_home_assistant" {
  path = "postgres/home_assistant"
  data_json = jsonencode({
    user     = var.postgres_home_assistant_user
    password = var.postgres_home_assistant_password
  })
}
