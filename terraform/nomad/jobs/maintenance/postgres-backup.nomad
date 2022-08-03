job "postgres-backup" {
  datacenters = ["homad"]
  type        = "sysbatch"
  region      = "global"

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
MINI0_ACCESS_KEY={{.Data.data.user}}
MINIO_SECRET_KEY={{.Data.data.password}} 
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
          checksum = "sha256:4b2a2ea71906c6b25977f9670af63712fd89792775af392e2b52b6e09b9355fa"
        }
      }
    }
  }
}
