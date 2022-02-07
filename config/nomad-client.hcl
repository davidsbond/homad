datacenter = "dc1"
data_dir   = "/opt/nomad"

client {
  enabled = true

  server_join {
    retry_join = ["192.168.0.21", "192.168.0.19", "192.168.0.20"]
  }

  host_volume "grafana" {
    path      = "/mnt/usb/grafana"
    read_only = false
  }

  host_volume "home-assistant" {
    path      = "/mnt/usb/home-assistant"
    read_only = false
  }

  host_volume "bitwarden" {
    path      = "/mnt/usb/bitwarden"
    read_only = false
  }

  host_volume "pihole" {
    path      = "/mnt/usb/pihole"
    read_only = false
  }

  host_volume "traefik" {
    path      = "/mnt/usb/traefik"
    read_only = false
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
