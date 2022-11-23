terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.31.1"
    }
  }
}

provider "grafana" {
  url  = var.url
  auth = "${var.email}:${var.password}"
}
