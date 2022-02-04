datacenter = "dc1"
data_dir   = "/opt/nomad"

client {
  enabled = true

  server_join {
    retry_join = ["192.168.0.21", "192.168.0.19", "192.168.0.20"]
  }
}

plugin "docker" {
  config {
    allow_privileged = true
  }
}

vault {
  enabled = true
  address = "http://192.168.0.21:8200"
}
