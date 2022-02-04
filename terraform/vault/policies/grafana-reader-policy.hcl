# Allow reading grafana credentials
path "grafana/*" {
  capabilities = ["read"]
}
