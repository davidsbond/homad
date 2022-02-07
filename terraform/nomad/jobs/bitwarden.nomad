job "bitwarden" {
  datacenters = ["dc1"]
  type        = "service"
  region      = "global"

  group "bitwarden" {
    network {
      port "bitwarden" {
        to = 80
      }
    }

    volume "bitwarden" {
      type      = "host"
      read_only = false
      source    = "bitwarden"
    }

    service {
      name = "bitwarden"
      port = "bitwarden"
      task = "bitwarden"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.bitwarden.rule=Host(`bitwarden.homad.dsb.dev`)",
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

      volume_mount {
        volume      = "bitwarden"
        destination = "/data"
        read_only   = false
      }

      config {
        image = "vaultwarden/server:1.24.0"
        ports = ["bitwarden"]
      }
    }
  }
}
