job "ubuntu-upgrade" {
  datacenters = ["homad"]
  type        = "sysbatch"
  region      = "global"

  periodic {
    cron             = "@daily"
    prohibit_overlap = true
  }

  group "distribution" {
    reschedule {
      attempts       = 5
      interval       = "2m"
      delay          = "10s"
      max_delay      = "30s"
      delay_function = "exponential"
    }

    task "dist-upgrade" {
      driver = "raw_exec"

      config {
        command = "apt-get"
        args    = ["dist-upgrade", "-y"]
      }
    }
  }

  group "packages" {
    reschedule {
      attempts       = 5
      interval       = "2m"
      delay          = "10s"
      max_delay      = "30s"
      delay_function = "exponential"
    }

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
