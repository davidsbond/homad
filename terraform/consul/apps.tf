resource "consul_key_prefix" "speed_dial" {
  path_prefix = "homad/speed-dial/"
  subkeys = {
    "config.yaml" = file("${path.module}/files/speed-dial/config.yaml")
  }
}
