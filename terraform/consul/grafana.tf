resource "consul_key_prefix" "grafana" {
  path_prefix = "homad/grafana/"
  subkeys = {
    "grafana.ini" = file("${path.module}/files/grafana/grafana.ini")
  }
}
