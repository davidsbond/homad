job "prometheus-exporter-pihole" {
  region      = "global"
  datacenters = ["homad"]
  type        = "service"
  namespace   = "monitoring"

  group "prometheus-exporter-pihole" {
    count = 1

    network {
      port "metrics" {
        to = 9617
      }
    }

    service {
      name = "prometheus-exporter-pihole"
      task = "prometheus-exporter-pihole"
      port = "metrics"
    }

    task "prometheus-exporter-pihole" {
      driver = "docker"

      vault {
        policies      = ["pihole-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }

      config {
        image = "ekofr/pihole-exporter:v0.3.0"
        ports = ["metrics"]
      }

      template {
        destination = "local/pihole.env"
        env         = true
        data        = <<EOT
PIHOLE_HOSTNAME={{- range $i, $instance := service "pihole" }}{{ $instance.Address }}{{ if eq $i 0  }},{{end}}{{ end }}
PIHOLE_PORT={{- range $i, $instance := service "pihole" }}{{ $instance.Port }}{{ if eq $i 0  }},{{end}}{{ end }}
PIHOLE_PROTOCOL=http
EOT
      }
      template {
        destination = "secrets/pihole.env"
        env         = true
        data        = <<EOT
{{- with secret "pihole/data/auth" }}
PIHOLE_PASSWORD={{.Data.data.password}}
{{ end }}
EOT
      }
    }
  }
}
