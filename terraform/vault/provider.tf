terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.8.1"
    }
  }
}

provider "vault" {
  address = var.address
  token   = var.token
}
