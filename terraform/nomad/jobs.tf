resource "nomad_job" "bitwarden" {
  jobspec = file("${path.module}/jobs/bitwarden.nomad")
}

resource "nomad_job" "traefik" {
  jobspec = file("${path.module}/jobs/traefik.nomad")
}

resource "nomad_job" "pihole" {
  jobspec = file("${path.module}/jobs/pihole.nomad")
}

resource "nomad_job" "home_assistant" {
  jobspec = file("${path.module}/jobs/home-assistant.nomad")
}

resource "nomad_job" "grafana" {
  jobspec = file("${path.module}/jobs/grafana.nomad")
}

resource "nomad_job" "emulatorjs" {
  jobspec = file("${path.module}/jobs/emulatorjs.nomad")
}
