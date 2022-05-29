resource "consul_key_prefix" "pihole" {
  path_prefix = "homad/pihole/"
  subkeys = {
    "TZ"            = "Europe/London"
    "VIRTUAL_HOST"  = "pihole.homelab.dsb.dev"
    "DNSSEC"        = "true"
    "QUERY_LOGGING" = "true"
  }
}
