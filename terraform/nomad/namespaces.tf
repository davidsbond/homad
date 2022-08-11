resource "nomad_namespace" "apps" {
  name        = "apps"
  description = "The namespace for custom applications"
}

resource "nomad_namespace" "maintenance" {
  name        = "maintenance"
  description = "The namespace for periodic maintenance tasks"
}

resource "nomad_namespace" "monitoring" {
  name        = "monitoring"
  description = "The namespace for jobs that provide monitoring tools"
}

resource "nomad_namespace" "storage" {
  name        = "storage"
  description = "The namespace for jobs that provide storage functionality"
}

resource "nomad_namespace" "networking" {
  name        = "networking"
  description = "The namespace for jobs that provide networking functionality"
}

resource "nomad_namespace" "security" {
  name        = "security"
  description = "The namespace for jobs that provide security functionality"
}
