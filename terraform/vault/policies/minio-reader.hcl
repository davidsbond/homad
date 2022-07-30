# Allow reading minio credentials
path "minio/*" {
  capabilities = ["read"]
}
