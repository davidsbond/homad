terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.16.0"
    }
  }
}

provider "postgresql" {
  host     = var.host
  username = var.user
  password = var.password
  sslmode  = "disable"
}
