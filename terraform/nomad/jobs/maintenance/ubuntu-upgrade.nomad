job "ubuntu-upgrade" {
  datacenters = ["homad"]
  type        = "sysbatch"
  region      = "global"

  periodic {
    cron             = "@daily"
    prohibit_overlap = true
  }

  group "distribution" {
    task "dist-upgrade" {
      driver = "raw_exec"

      config {
        command = "apt-get"
        args    = ["dist-upgrade", "-y"]
      }
    }
  }

  group "packages" {
    task "update" {
      driver = "raw_exec"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        command = "apt-get"
        args    = ["update"]
      }
    }

    task "upgrade" {
      driver = "raw_exec"

      config {
        command = "apt-get"
        args    = ["upgrade", "-y"]
      }
    }

    task "autoremove" {
      driver = "raw_exec"

      lifecycle {
        hook    = "poststop"
        sidecar = false
      }

      config {
        command = "apt-get"
        args    = ["autoremove", "-y"]
      }
    }
  }
}
