job "pihole" {
  region      = "global"
  datacenters = ["dc1"]
  type        = "system"

  group "pihole" {
    count = 1

    volume "pihole" {
      type      = "host"
      read_only = false
      source    = "pihole"
    }

    network {
      port "pihole" {
        to = 80
      }

      port "dns" {
        static = 53
      }
    }

    service {
      name = "pihole"
      port = "pihole"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.pihole.rule=Host(`pihole.homad.dsb.dev`)",
        "traefik.http.routers.pihole.entrypoints=https",
        "traefik.http.routers.pihole.tls.certresolver=cloudflare"
      ]

      check {
        type     = "http"
        path     = "/"
        interval = "60s"
        timeout  = "30s"
      }
    }

    task "pihole" {
      driver = "docker"

      volume_mount {
        volume      = "pihole"
        destination = "/etc/pihole"
        read_only   = false
      }

      config {
        image = "pihole/pihole:2022.01.1"

        ports = [
          "dns",
          "pihole"
        ]
      }

      template {
        destination = "local/pihole.env"
        env         = true
        data        = <<EOT
{{ range ls "homad/pihole" }}
{{.Key}}={{.Value}}
{{ end }}
EOT
      }
    }
  }
}
