job "ubuntu-upgrade" {
  datacenters = ["homad"]
  type        = "sysbatch"
  region      = "global"

  periodic {
    cron             = "@daily"
    prohibit_overlap = true
  }

  group "ubuntu-upgrade" {
    task "ubuntu-upgrade" {
      driver = "raw_exec"

      config {
        command = "./upgrade-ubuntu.sh"
      }

      artifact {
        source = "https://raw.githubusercontent.com/davidsbond/homad/master/scripts/upgrade-ubuntu.sh"
        options {
          checksum = "sha256:5764395f1c9c3443f9268debf3455136138d2c99e64dbc5655e0ef033d8f3105"
        }
      }
    }
  }
}
