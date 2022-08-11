job "ubuntu-upgrade" {
  datacenters = ["homad"]
  type        = "sysbatch"
  region      = "global"
  namespace   = "maintenance"

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
          checksum = "sha256:c62a5890e61f170a4caee1bf840c3cea44d35061ce6d1b476a53cc2350c6dc06"
        }
      }
    }
  }
}
