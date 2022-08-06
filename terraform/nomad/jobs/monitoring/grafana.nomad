job "grafana" {
  region      = "global"
  datacenters = ["homad"]
  type        = "service"

  group "grafana" {
    network {
      port "grafana" {
        to = 3000
      }
    }

    volume "grafana" {
      type            = "csi"
      source          = "grafana"
      read_only       = false
      attachment_mode = "file-system"
      access_mode     = "multi-node-multi-writer"
    }

    task "grafana" {
      driver = "docker"
      user   = "root"

      vault {
        policies      = ["grafana-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }

      config {
        image = "grafana/grafana:9.0.2"
        ports = ["grafana"]
      }

      volume_mount {
        volume      = "grafana"
        destination = "/var/lib/grafana"
      }

      logs {
        max_files = 1
      }

      template {
        destination = "secrets/grafana.env"
        env         = true
        data        = <<EOT
{{- with secret "grafana/data/admin" }}
GF_SECURITY_ADMIN_USER={{.Data.data.email}}
GF_SECURITY_ADMIN_PASSWORD={{.Data.data.password}}
{{ end }}
EOT
      }

      service {
        name = "grafana"
        port = "grafana"

        tags = [
          "traefik.enable=true",
          "traefik.http.routers.grafana.rule=Host(`grafana.homelab.dsb.dev`)",
          "traefik.http.routers.grafana.entrypoints=https",
          "traefik.http.routers.grafana.tls.certresolver=cloudflare",
        ]

        check {
          type     = "http"
          path     = "/api/health"
          interval = "60s"
          timeout  = "30s"
        }
      }
    }
  }
}
