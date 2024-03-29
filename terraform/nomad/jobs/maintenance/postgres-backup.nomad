job "postgres-backup" {
  datacenters = ["homad"]
  type        = "batch"
  region      = "global"
  namespace   = "maintenance"

  periodic {
    cron             = "@hourly"
    prohibit_overlap = true
  }

  group "postgres-backup" {
    task "backup" {
      driver = "raw_exec"

      config {
        command = "./backup-database.sh"
      }

      vault {
        policies      = ["minio-reader", "postgres-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }

      template {
        destination = "secrets/minio.env"
        env         = true
        data        = <<EOT
{{- with secret "minio/data/root" }}
MINIO_ACCESS_KEY={{.Data.data.user}}
MINIO_SECRET_KEY={{.Data.data.password}}
MINIO_HOST=https://api.minio.homelab.dsb.dev
{{ end }}
EOT
      }

      template {
        destination = "secrets/postgres.env"
        env         = true
        data        = <<EOT
{{- with secret "postgres/data/root" }}
PGUSER={{.Data.data.user}}
PGPASSWORD={{.Data.data.password}}
PGHOST=postgres.homelab.dsb.dev
{{ end }}
EOT
      }

      artifact {
        source = "https://raw.githubusercontent.com/davidsbond/homad/master/scripts/backup-database.sh"
        options {
          checksum = "sha256:93959e944e41346f2e13eac2452170e05a92f4ba916060b1d9e84a2070fc26f4"
        }
      }
    }
  }
}
