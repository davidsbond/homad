terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.17.1"
    }
  }
}

provider "postgresql" {
  host     = var.host
  username = var.username
  password = var.password
  sslmode  = "disable"
}
