job "pihole" {
  region      = "global"
  datacenters = ["homad"]
  type        = "service"

  group "pihole" {
    count = 2

    update {
      max_parallel = 1
    }

    constraint {
      operator = "distinct_hosts"
      value    = "true"
    }

    ephemeral_disk {
      migrate = true
      size    = 100
      sticky  = true
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
        "traefik.http.routers.pihole.rule=Host(`pihole.homelab.dsb.dev`)",
        "traefik.http.routers.pihole.entrypoints=https",
        "traefik.http.routers.pihole.tls.certresolver=cloudflare",
        "traefik.http.services.pihole.loadBalancer.sticky.cookie.name=pihole"
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

      vault {
        policies      = ["pihole-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }

      config {
        image = "pihole/pihole:2022.04.3"

        ports = [
          "dns",
          "pihole"
        ]

        volumes = [
          "local/storage/pihole:/etc/pihole",
          "local/storage/dnsmasq:/etc/dnsmasq.d",
        ]
      }

      logs {
        max_files = 1
      }

      template {
        destination = "secrets/pihole.env"
        env         = true
        data        = <<EOT
{{- with secret "pihole/data/auth" }}
WEBPASSWORD={{.Data.data.password}}
{{ end }}
EOT
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

    task "cloudflared" {
      driver = "docker"

      config {
        image   = "raspbernetes/cloudflared:2022.5.1"
        command = "cloudflared"
        args = [
          "--no-autoupdate",
          "--proxy-dns"
        ]
      }

      logs {
        max_files = 1
      }

      template {
        destination = "local/cloudflared.env"
        env         = true
        data        = <<EOT
{{ range ls "homad/cloudflared" }}
{{.Key}}={{.Value}}
{{ end }}
EOT
      }
    }
  }
}
