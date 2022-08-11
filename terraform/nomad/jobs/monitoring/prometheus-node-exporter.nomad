job "prometheus-node-exporter" {
  region      = "global"
  datacenters = ["homad"]
  type        = "system"
  namespace   = "monitoring"

  group "node-exporter" {
    count = 1

    network {
      port "metrics" {
        to = 9100
      }
    }

    service {
      name = "node-exporter"
      port = "metrics"
      task = "node-exporter"
    }

    task "node-exporter" {
      driver = "docker"

      config {
        image = "prom/node-exporter:v1.3.1"
        ports = ["metrics"]
        args = [
          "--path.procfs=/host/proc",
          "--path.sysfs=/host/sys"
        ]
        volumes = [
          "/proc:/host/proc:ro",
          "/sys:/host/sys:ro"
        ]
      }
    }
  }
}
