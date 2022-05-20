# Allow reading postgres credentials
path "postgres/*" {
  capabilities = ["read"]
}
