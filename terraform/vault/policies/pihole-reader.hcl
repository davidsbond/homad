# Allow reading pihole credentials
path "pihole/*" {
  capabilities = ["read"]
}
