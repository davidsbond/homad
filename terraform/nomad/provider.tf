terraform {
  required_providers {
    nomad = {
      source  = "hashicorp/nomad"
      version = "1.4.16"
    }
  }
}

provider "nomad" {
  address = var.address
}
