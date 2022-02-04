datacenter = "dc1"
data_dir   = "/opt/nomad"

server {
  enabled          = true
  bootstrap_expect = 3

  server_join {
    retry_join = ["192.168.0.21", "192.168.0.19", "192.168.0.20"]
  }
}

vault {
  enabled          = true
  address          = "http://localhost:8200"
  create_from_role = "nomad-cluster"
  token            = ""
}
