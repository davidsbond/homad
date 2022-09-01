terraform {
  required_providers {
    nomad = {
      source  = "hashicorp/nomad"
      version = "1.4.18"
    }
  }
}

provider "nomad" {
  address = var.address
}
