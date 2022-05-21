resource "random_password" "home_assistant" {
  length  = 16
  special = false
}

resource "postgresql_role" "home_assistant" {
  name     = "home_assistant"
  login    = true
  password = random_password.home_assistant.result
}

resource "postgresql_database" "home_assistant" {
  name  = "home_assistant"
  owner = postgresql_role.home_assistant.name
}

output "home_assistant_database_name" {
  value = postgresql_database.home_assistant.name
}

output "home_assistant_database_user" {
  value = postgresql_role.home_assistant.name
}

output "home_assistant_database_password" {
  value = random_password.home_assistant.result
}
