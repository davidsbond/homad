terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "2.15.1"
    }
  }
}

provider "consul" {
  address = var.address
}
