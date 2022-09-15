terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.28.2"
    }
  }
}

provider "grafana" {
  url  = var.url
  auth = "${var.email}:${var.password}"
}
