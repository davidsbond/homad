job "boundary" {
  datacenters = ["homad"]
  type        = "service"
  region      = "global"

  group "boundary" {
    network {
      port "controller" {
        to = 9200
      }

      port "worker" {
        to = 9201
      }

      port "comm" {
        to = 9202
      }
    }

    ephemeral_disk {
      migrate = true
      size    = 100
      sticky  = true
    }

    task "database-init" {
      driver = "docker"

      config {
        image   = "hashicorp/boundary:0.8.1"
        command = "database"
        args = [
          "init",
          "-config",
          "/boundary/boundary.hcl"
        ]

        volumes    = ["secrets/boundary.hcl:/boundary/boundary.hcl"]
        init       = true
        privileged = true
      }

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      vault {
        policies      = ["postgres-reader", "boundary-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }

      template {
        destination = "secrets/boundary.env"
        env         = true
        data        = <<EOT
{{- with secret "postgres/data/boundary" }}
BOUNDARY_POSTGRES_URL=postgresql://{{.Data.data.user}}:{{.Data.data.password}}@postgres.homelab.dsb.dev:5432/boundary?sslmode=disable
{{ end }}
EOT
      }

      template {
        destination = "secrets/boundary.hcl"
        data        = <<EOT
{{- with secret "boundary/data/config" }}
{{.Data.data.config}}
{{ end }}
EOT
      }

      logs {
        max_files = 1
      }
    }

    service {
      name = "boundary"
      port = "controller"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.boundary.rule=Host(`boundary.homelab.dsb.dev`)",
        "traefik.http.routers.boundary.entrypoints=https",
        "traefik.http.routers.boundary.tls.certresolver=cloudflare",
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "60s"
        timeout  = "30s"
      }
    }

    task "boundary" {
      driver = "docker"

      config {
        image      = "hashicorp/boundary:0.8.1"
        ports      = ["controller", "worker", "comm"]
        volumes    = ["secrets/boundary.hcl:/boundary/boundary.hcl"]
        privileged = true
      }

      vault {
        policies      = ["postgres-reader", "boundary-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }

      template {
        destination = "secrets/boundary.env"
        env         = true
        data        = <<EOT
{{- with secret "postgres/data/boundary" }}
BOUNDARY_POSTGRES_URL=postgresql://{{.Data.data.user}}:{{.Data.data.password}}@postgres.homelab.dsb.dev:5432/boundary?sslmode=disable
{{ end }}
EOT
      }

      template {
        destination = "secrets/boundary.hcl"
        data        = <<EOT
{{- with secret "boundary/data/config" }}
{{.Data.data.config}}
{{ end }}
EOT
      }

      logs {
        max_files = 1
      }
    }
  }
}
