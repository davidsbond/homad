# Allow reading cloudflare credentials
path "postgres/*" {
  capabilities = ["read"]
}
