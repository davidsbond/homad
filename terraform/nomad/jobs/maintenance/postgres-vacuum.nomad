job "postgres-vacuum" {
  datacenters = ["homad"]
  type        = "batch"
  region      = "global"
  namespace   = "maintenance"

  periodic {
    cron             = "@daily"
    prohibit_overlap = true
  }

  group "postgres-vacuum" {
    task "vacuum" {
      driver = "raw_exec"

      config {
        command = "vacuumdb"
        args    = ["--all", "--skip-locked", "--full"]
      }

      vault {
        policies      = ["postgres-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
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
    }
  }
}
