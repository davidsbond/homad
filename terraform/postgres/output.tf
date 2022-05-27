output "home_assistant_password" {
  value = random_password.home_assistant.result
}

output "home_assistant_username" {
  value = postgresql_role.home_assistant.name
}
