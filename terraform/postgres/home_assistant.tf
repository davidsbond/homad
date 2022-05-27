resource "random_password" "home_assistant" {
  special = false
  length  = 16
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
