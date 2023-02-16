terraform {
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.1.4"
    }
  }
}

provider "boundary" {
  addr             = var.addr
  token            = var.token
  recovery_kms_hcl = var.recovery_kms_file
}
