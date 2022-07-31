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

    volume "home-assistant" {
      type            = "csi"
      source          = "home-assistant"
      read_only       = false
      attachment_mode = "file-system"
      access_mode     = "multi-node-multi-writer"
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

      vault {
        policies      = ["postgres-reader"]
        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }

      config {
        image = "homeassistant/home-assistant:2022.6"
        ports = ["homeassistant"]

        volumes = [
          "local/automations.yaml:/config/automations.yaml",
          "local/configuration.yaml:/config/configuration.yaml",
          "local/groups.yaml:/config/groups.yaml",
          "local/scenes.yaml:/config/scenes.yaml",
          "local/scripts.yaml:/config/scripts.yaml",
          "local/ui-lovelace.yaml:/config/ui-lovelace.yaml",
          "local/ui-internet.yaml:/config/ui-internet.yaml",
          "local/ui-lighting.yaml:/config/ui-lighting.yaml",
          "secrets/secrets.yaml:/config/secrets.yaml"
        ]
      }

      volume_mount {
        volume      = "home-assistant"
        destination = "/config/.storage"
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

      template {
        destination = "local/ui-internet.yaml"
        data        = <<EOT
{{- key "homad/home-assistant/ui-internet.yaml" }}
EOT
      }

      template {
        destination = "local/ui-lighting.yaml"
        data        = <<EOT
{{- key "homad/home-assistant/ui-lighting.yaml" }}
EOT
      }

      template {
        destination = "secrets/secrets.yaml"
        data        = <<EOT
{{- with secret "postgres/data/home_assistant" }}
db_url: postgresql://{{.Data.data.user}}:{{.Data.data.password}}@postgres.homelab.dsb.dev:5432/home_assistant?sslmode=disable
{{ end }}
EOT
      }
    }
  }
}
