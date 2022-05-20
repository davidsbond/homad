resource "consul_key_prefix" "cloudflared" {
  path_prefix = "homad/cloudflared/"
  subkeys = {
    "TUNNEL_DNS_ADDRESS"  = "0.0.0.0"
    "TUNNEL_DNS_PORT"     = "5053"
    "TUNNEL_DNS_UPSTREAM" = " https://1.1.1.1/dns-query,https://1.0.0.1/dns-query"
  }
}
