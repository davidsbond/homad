job "speed-dial" {
  region      = "global"
  datacenters = ["homad"]
  type        = "service"
  namespace   = "apps"

  group "speed-dial" {
    network {
      port "server" {
        to = 8080
      }
    }

    service {
      name = "speed-dial"
      port = "server"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.speed-dial.rule=Host(`apps.homelab.dsb.dev`)",
        "traefik.http.routers.speed-dial.entrypoints=https",
        "traefik.http.routers.speed-dial.tls.certresolver=cloudflare",
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "60s"
        timeout  = "30s"
      }
    }

    task "speed-dial" {
      driver = "docker"

      config {
        image = "ghcr.io/davidsbond/homad-speed-dial:f44d9d91fba2d0de88b37f3892d78f9e423de79f"
        ports = ["server"]
        args  = ["--config=/etc/speed-dial/config.yaml"]
        volumes = [
          "local/config.yaml:/etc/speed-dial/config.yaml",
        ]
      }

      template {
        destination = "local/config.yaml"
        data        = <<EOT
{{- key "homad/speed-dial/config.yaml" }}
EOT
      }

      logs {
        max_files = 1
      }
    }
  }
}
