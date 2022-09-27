terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "2.16.2"
    }
  }
}

provider "consul" {
  address = var.address
}
