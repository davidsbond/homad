job "emulatorjs" {
  datacenters = ["dc1"]
  type        = "service"
  region      = "global"

  group "emulatorjs" {
    network {
      port "frontend" {
        to = 80
      }

      port "backend" {
        to = 3000
      }
    }

    ephemeral_disk {
      migrate = true
      size    = 10240
      sticky  = true
    }

    service {
      name = "emulatorjs"
      port = "frontend"
      task = "emulatorjs"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.emulatorjs.rule=Host(`emulatorjs.homad.dsb.dev`)",
        "traefik.http.routers.emulatorjs.entrypoints=https",
        "traefik.http.routers.emulatorjs.tls.certresolver=cloudflare"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "30s"
        port     = "frontend"
      }
    }

    task "emulatorjs" {
      driver = "docker"

      config {
        image = "lscr.io/linuxserver/emulatorjs"
        ports = ["frontend", "backend"]

        volumes = [
          "local/data:/data",
          "local/config:/config"
        ]
      }

      logs {
        max_files = 1
      }
    }
  }
}
