resource "consul_key_prefix" "prometheus" {
  path_prefix = "homad/prometheus/"
  subkeys = {
    "prometheus.yml" = file("${path.module}/files/prometheus/prometheus.yml"),
  }
}
