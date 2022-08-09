job "prometheus" {
  region      = "global"
  datacenters = ["homad"]
  type        = "service"

  group "prometheus" {
    count = 1

    network {
      port "prometheus" {
        to = 9090
      }
    }

    volume "prometheus" {
      type            = "csi"
      source          = "prometheus"
      read_only       = false
      attachment_mode = "file-system"
      access_mode     = "multi-node-multi-writer"
    }

    service {
      name = "prometheus"
      port = "prometheus"
      task = "prometheus"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.prometheus.rule=Host(`prometheus.homelab.dsb.dev`)",
        "traefik.http.routers.prometheus.entrypoints=https",
        "traefik.http.routers.prometheus.tls.certresolver=cloudflare"
      ]

      check {
        name     = "prometheus"
        type     = "http"
        path     = "/-/healthy"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "prometheus" {
      driver = "docker"
      user   = "root"

      vault {
        policies      = ["home-assistant-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }

      config {
        image = "prom/prometheus:v2.37.0"
        ports = ["prometheus"]
        volumes = [
          "local/prometheus.yml:/etc/prometheus/prometheus.yml",
          "secrets/home-assistant:/etc/home-assistant/credentials"
        ]
      }

      volume_mount {
        volume      = "prometheus"
        destination = "/prometheus"
      }

      template {
        destination = "secrets/home-assistant"
        data        = <<EOT
{{- with secret "home-assistant/data/auth" }}
{{.Data.data.access_token}}
{{ end }}
EOT
      }

      template {
        destination = "local/prometheus.yml"
        data        = <<EOT
{{- key "homad/prometheus/prometheus.yml" }}
EOT
      }
    }
  }
}
