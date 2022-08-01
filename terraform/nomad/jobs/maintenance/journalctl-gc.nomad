job "journalctl-gc" {
  datacenters = ["homad"]
  type        = "sysbatch"
  region      = "global"

  periodic {
    cron             = "@daily"
    prohibit_overlap = true
  }

  group "garbage-collection" {
    task "garbage-collection" {
      driver = "raw_exec"

      config {
        command = "journalctl"
        args    = ["--vacuum-time", "7d"]
      }
    }
  }
}
