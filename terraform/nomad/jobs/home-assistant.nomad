job "homeassistant" {
  datacenters = ["homad"]
  type        = "service"
  region      = "global"

  group "homeassistant" {
    network {
      port "homeassistant" {
        to = 8123
      }
    }

    ephemeral_disk {
      migrate = true
      size    = 100
      sticky  = true
    }

    service {
      name = "homeassistant"
      port = "homeassistant"
      task = "homeassistant"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.homeassistant.rule=Host(`home-assistant.homelab.dsb.dev`)",
        "traefik.http.routers.homeassistant.entrypoints=https",
        "traefik.http.routers.homeassistant.tls.certresolver=cloudflare"
      ]

      check {
        type     = "tcp"
        port     = "homeassistant"
        interval = "10s"
        timeout  = "30s"
      }
    }

    task "homeassistant" {
      driver = "docker"

      config {
        image = "homeassistant/home-assistant:2022.5"
        ports = ["homeassistant"]

        volumes = [
          "local/automations.yaml:/config/automations.yaml",
          "local/configuration.yaml:/config/configuration.yaml",
          "local/groups.yaml:/config/groups.yaml",
          "local/scenes.yaml:/config/scenes.yaml",
          "local/scripts.yaml:/config/scripts.yaml",
          "local/ui-lovelace.yaml:/config/ui-lovelace.yaml",
          "local/storage:/config/.storage"
        ]
      }

      logs {
        max_files = 1
      }

      template {
        destination = "local/automations.yaml"
        data        = <<EOT
{{- key "homad/home-assistant/automations.yaml" }}
EOT
      }

      template {
        destination = "local/configuration.yaml"
        data        = <<EOT
{{- key "homad/home-assistant/configuration.yaml" }}
EOT
      }

      template {
        destination = "local/groups.yaml"
        data        = <<EOT
{{- key "homad/home-assistant/groups.yaml" }}
EOT
      }

      template {
        destination = "local/scenes.yaml"
        data        = <<EOT
{{- key "homad/home-assistant/scenes.yaml" }}
EOT
      }

      template {
        destination = "local/scripts.yaml"
        data        = <<EOT
{{- key "homad/home-assistant/scripts.yaml" }}
EOT
      }

      template {
        destination = "local/ui-lovelace.yaml"
        data        = <<EOT
{{- key "homad/home-assistant/ui-lovelace.yaml" }}
EOT
      }
    }
  }
}
