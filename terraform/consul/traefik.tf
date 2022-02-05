resource "consul_key_prefix" "traefik" {
  path_prefix = "homad/traefik/"
  subkeys = {
    "traefik.yaml"  = file("${path.module}/files/traefik/traefik.yaml"),
    "external.yaml" = file("${path.module}/files/traefik/external.yaml"),
  }
}
