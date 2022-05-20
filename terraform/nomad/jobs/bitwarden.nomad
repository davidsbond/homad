job "bitwarden" {
  datacenters = ["homad"]
  type        = "service"
  region      = "global"

  group "bitwarden" {
    network {
      port "bitwarden" {
        to = 80
      }
    }

    ephemeral_disk {
      migrate = true
      size    = 100
      sticky  = true
    }

    service {
      name = "bitwarden"
      port = "bitwarden"
      task = "bitwarden"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.bitwarden.rule=Host(`bitwarden.homelab.dsb.dev`)",
        "traefik.http.routers.bitwarden.entrypoints=https",
        "traefik.http.routers.bitwarden.tls.certresolver=cloudflare"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "30s"
      }
    }

    task "bitwarden" {
      driver = "docker"

      config {
        image = "vaultwarden/server:1.24.0"
        ports = ["bitwarden"]

        volumes = [
          "local/data:/data"
        ]
      }

      logs {
        max_files = 1
      }
    }
  }
}
