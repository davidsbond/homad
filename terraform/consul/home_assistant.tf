resource "consul_key_prefix" "home_assistant" {
  path_prefix = "homad/home-assistant/"
  subkeys = {
    "automations.yaml"   = file("${path.module}/files/home-assistant/automations.yaml")
    "configuration.yaml" = file("${path.module}/files/home-assistant/configuration.yaml")
    "groups.yaml"        = file("${path.module}/files/home-assistant/groups.yaml")
    "scenes.yaml"        = file("${path.module}/files/home-assistant/scenes.yaml")
    "scripts.yaml"       = file("${path.module}/files/home-assistant/scripts.yaml")
    "ui-lovelace.yaml"   = file("${path.module}/files/home-assistant/ui-lovelace.yaml")
    "ui-internet.yaml"   = file("${path.module}/files/home-assistant/ui-internet.yaml")
    "ui-lighting.yaml"   = file("${path.module}/files/home-assistant/ui-lighting.yaml")
  }
}
