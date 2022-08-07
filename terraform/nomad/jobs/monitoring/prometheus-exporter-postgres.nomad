job "prometheus-exporter-postgres" {
  region      = "global"
  datacenters = ["homad"]
  type        = "service"

  group "prometheus-exporter-postgres" {
    count = 1

    network {
      port "metrics" {
        to = 9187
      }
    }

    service {
      name = "prometheus-exporter-postgres"
      port = "metrics"
      task = "prometheus-exporter-postgres"
    }

    task "prometheus-exporter-postgres" {
      driver = "docker"

      vault {
        policies      = ["postgres-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }

      config {
        image = "prometheuscommunity/postgres-exporter:v0.11.0"
        ports = ["metrics"]
        args = [
          "--auto-discover-databases"
        ]
      }

      template {
        destination = "secrets/postgres.env"
        env         = true
        data        = <<EOT
{{- with secret "postgres/data/root" }}
DATA_SOURCE_NAME=postgresql://{{.Data.data.user}}:{{.Data.data.password}}@postgres.homelab.dsb.dev:5432/postgres?sslmode=disable
{{ end }}
EOT
      }
    }
  }
}
