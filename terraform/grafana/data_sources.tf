resource "grafana_data_source" "prometheus" {
  type = "prometheus"
  name = "prometheus"
  url  = "https://prometheus.homelab.dsb.dev"
}
