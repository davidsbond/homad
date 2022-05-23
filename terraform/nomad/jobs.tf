resource "nomad_job" "bitwarden" {
  jobspec = file("${path.module}/jobs/bitwarden.nomad")
}

resource "nomad_job" "traefik" {
  jobspec = file("${path.module}/jobs/traefik.nomad")
}

resource "nomad_job" "home_assistant" {
  jobspec = file("${path.module}/jobs/home-assistant.nomad")
}

resource "nomad_job" "pihole" {
  jobspec = file("${path.module}/jobs/pihole.nomad")
}

resource "nomad_job" "postgres" {
  jobspec = file("${path.module}/jobs/postgres.nomad")
}

resource "nomad_job" "storage_controller" {
  jobspec = file("${path.module}/jobs/csi/controller.nomad")
}

resource "nomad_job" "storage_node" {
  jobspec = file("${path.module}/jobs/csi/node.nomad")
}
