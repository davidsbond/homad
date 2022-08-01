job "nomad-gc" {
  datacenters = ["homad"]
  type        = "batch"
  region      = "global"

  periodic {
    cron             = "@daily"
    prohibit_overlap = true
  }

  group "garbage-collection" {
    task "garbage-collection" {
      driver = "raw_exec"

      config {
        command = "nomad"
        args    = ["system", "gc", "--address", "https://homelab.dsb.dev"]
      }
    }
  }
}
