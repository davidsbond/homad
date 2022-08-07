job "minio" {
  datacenters = ["homad"]
  type        = "service"
  region      = "global"

  group "minio" {
    network {
      port "api" {
        to = 9000
      }

      port "ui" {
        to = 9001
      }
    }

    volume "minio" {
      type            = "csi"
      source          = "minio"
      read_only       = false
      attachment_mode = "file-system"
      access_mode     = "multi-node-multi-writer"
    }

    ephemeral_disk {
      migrate = true
      size    = 100
      sticky  = true
    }

    service {
      name = "minio-api"
      port = "api"
      task = "minio"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.minio-api.rule=Host(`api.minio.homelab.dsb.dev`)",
        "traefik.http.routers.minio-api.entrypoints=https",
        "traefik.http.routers.minio-api.tls.certresolver=cloudflare"
      ]

      check {
        type     = "http"
        path     = "/minio/health/live"
        interval = "10s"
        timeout  = "30s"
      }
    }

    service {
      name = "minio-ui"
      port = "ui"
      task = "minio"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.minio-ui.rule=Host(`ui.minio.homelab.dsb.dev`)",
        "traefik.http.routers.minio-ui.entrypoints=https",
        "traefik.http.routers.minio-ui.tls.certresolver=cloudflare"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "30s"
      }
    }

    task "minio" {
      driver = "docker"

      config {
        image = "quay.io/minio/minio:RELEASE.2022-07-30T05-21-40Z"
        ports = ["api", "ui"]
        args  = ["server", "/data", "--console-address", ":9001"]
      }

      vault {
        policies      = ["minio-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }

      resources {
        memory = 1024
      }

      logs {
        max_files = 1
      }

      volume_mount {
        volume      = "minio"
        destination = "/data"
      }

      template {
        destination = "local/minio.env"
        env         = true
        data        = <<EOT
{{ range ls "homad/minio" }}
{{.Key}}={{.Value}}
{{ end }}
EOT
      }


      template {
        destination = "secrets/minio.env"
        env         = true
        data        = <<EOT
{{- with secret "minio/data/root" }}
MINIO_ROOT_USER={{.Data.data.user}}
MINIO_ROOT_PASSWORD={{.Data.data.password}}
{{ end }}
EOT
      }
    }
  }
}
