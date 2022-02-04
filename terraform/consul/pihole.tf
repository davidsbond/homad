resource "consul_key_prefix" "pihole" {
  path_prefix = "homad/pihole/"
  subkeys = {
    "TZ"           = "Europe/London"
    "DNS1"         = "8.8.8.8"
    "DNS2"         = "8.8.4.4"
    "VIRTUAL_HOST" = "pihole.homad.dsb.dev"
  }
}
