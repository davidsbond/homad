job "traefik" {
  region      = "global"
  datacenters = ["homad"]
  type        = "service"
  namespace   = "networking"

  group "traefik" {
    count = 4

    constraint {
      operator = "distinct_hosts"
      value    = "true"
    }

    update {
      max_parallel = 1
    }

    volume "traefik" {
      type            = "csi"
      source          = "traefik"
      read_only       = false
      attachment_mode = "file-system"
      access_mode     = "multi-node-multi-writer"
    }

    network {
      port "http" {
        static = 80
      }

      port "https" {
        static = 443
      }

      port "ping" {
        static = 8082
      }

      port "traefik" {
        static = 8080
      }

      port "metrics" {
        static = 8083
      }
    }

    ephemeral_disk {
      migrate = true
      size    = 100
      sticky  = true
    }

    service {
      name = "traefik"
      port = "traefik"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.traefik.rule=Host(`traefik.homelab.dsb.dev`)",
        "traefik.http.routers.traefik.entrypoints=https",
        "traefik.http.routers.traefik.tls.certresolver=cloudflare",
        "traefik.http.services.traefik.loadBalancer.sticky.cookie.name=traefik"
      ]

      check {
        type     = "http"
        path     = "/ping"
        interval = "10s"
        timeout  = "30s"
        port     = "ping"
      }
    }

    service {
      name = "traefik-metrics"
      port = "metrics"
    }

    task "traefik" {
      driver = "docker"

      vault {
        policies      = ["cloudflare-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }

      logs {
        max_files = 1
      }

      config {
        image        = "traefik:v2.8"
        network_mode = "host"

        args = [
          "--configFile=/etc/traefik/traefik.yaml"
        ]

        volumes = [
          "local/traefik.yaml:/etc/traefik/traefik.yaml",
          "local/external.yaml:/etc/traefik/common/external.yaml"
        ]
      }

      volume_mount {
        volume      = "traefik"
        destination = "/letsencrypt"
      }

      template {
        destination = "secrets/cloudflare.env"
        env         = true
        data        = <<EOT
{{- with secret "cloudflare/data/auth" }}
CF_API_EMAIL={{.Data.data.email}}
CF_API_KEY={{.Data.data.api_key}}
{{ end }}
EOT
      }

      template {
        destination = "local/traefik.yaml"
        data        = <<EOT
{{- key "homad/traefik/traefik.yaml" }}
EOT
      }

      template {
        destination = "local/external.yaml"
        data        = <<EOT
{{- key "homad/traefik/external.yaml" }}
EOT
      }
    }
  }
}
