resource "grafana_dashboard" "nodes" {
  config_json = file("${path.module}/dashboards/nodes.json")
}

resource "grafana_dashboard" "minio" {
  config_json = file("${path.module}/dashboards/minio.json")
}

resource "grafana_dashboard" "traefik" {
  config_json = file("${path.module}/dashboards/traefik.json")
}

resource "grafana_dashboard" "pihole" {
  config_json = file("${path.module}/dashboards/pihole.json")
}

resource "grafana_dashboard" "postgresql" {
  config_json = file("${path.module}/dashboards/postgresql.json")
}
