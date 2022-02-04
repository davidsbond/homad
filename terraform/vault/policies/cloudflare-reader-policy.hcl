# Allow reading cloudflare credentials
path "cloudflare/*" {
  capabilities = ["read"]
}
