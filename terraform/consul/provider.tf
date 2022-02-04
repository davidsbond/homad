terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "2.14.0"
    }
  }
}

provider "consul" {
  address = var.address
}
