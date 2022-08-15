job "storage-controller" {
  datacenters = ["homad"]
  type        = "service"
  namespace   = "csi"

  group "controller" {
    task "controller" {
      driver = "docker"

      config {
        image = "registry.gitlab.com/rocketduck/csi-plugin-nfs:0.4.0"

        args = [
          "--type=controller",
          "--node-id=${attr.unique.hostname}",
          "--nfs-server=192.168.0.22:/volume1/homad",
          "--mount-options=defaults",
        ]

        network_mode = "host"
        privileged   = true
      }

      csi_plugin {
        id        = "nfs"
        type      = "controller"
        mount_dir = "/csi"
      }
    }
  }
}
