job "nomad-config-backup" {
  datacenters = ["homad"]
  type        = "sysbatch"
  region      = "global"

  periodic {
    cron             = "@daily"
    prohibit_overlap = true
  }

  group "nomad-config-backup" {
    task "nomad-config-backup" {
      driver = "raw_exec"

      config {
        command = "./backup-nomad-config.sh"
      }

      vault {
        policies      = ["minio-reader"]
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

      artifact {
        source = "https://raw.githubusercontent.com/davidsbond/homad/master/scripts/backup-nomad-config.sh"
        options {
          checksum = "sha256:d1375ced1fc0f6058e5377c00054a965aabd9710f2ba1797ac9db23759d19494"
        }
      }
    }
  }
}
