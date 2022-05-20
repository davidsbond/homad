resource "consul_key_prefix" "pihole" {
  path_prefix = "homad/pihole/"
  subkeys = {
    "TZ"           = "Europe/London"
    "DNS1"         = "127.0.0.1#5053"
    "VIRTUAL_HOST" = "pihole.homelab.dsb.dev"
  }
}
