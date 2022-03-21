terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "2.15.0"
    }
  }
}

provider "consul" {
  address = var.address
}
