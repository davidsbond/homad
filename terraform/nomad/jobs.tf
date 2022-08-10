resource "nomad_job" "bitwarden" {
  jobspec = file("${path.module}/jobs/security/bitwarden.nomad")
}

resource "nomad_job" "traefik" {
  jobspec = file("${path.module}/jobs/networking/traefik.nomad")
}

resource "nomad_job" "home_assistant" {
  jobspec = file("${path.module}/jobs/monitoring/home-assistant.nomad")
}

resource "nomad_job" "pihole" {
  jobspec = file("${path.module}/jobs/networking/pihole.nomad")
}

resource "nomad_job" "postgres" {
  jobspec = file("${path.module}/jobs/storage/postgres.nomad")
}

resource "nomad_job" "storage_controller" {
  jobspec = file("${path.module}/jobs/csi/controller.nomad")
}

resource "nomad_job" "storage_node" {
  jobspec = file("${path.module}/jobs/csi/node.nomad")
}

resource "nomad_job" "grafana" {
  jobspec = file("${path.module}/jobs/monitoring/grafana.nomad")
}

resource "nomad_job" "boundary" {
  jobspec = file("${path.module}/jobs/security/boundary.nomad")
}

resource "nomad_job" "minio" {
  jobspec = file("${path.module}/jobs/storage/minio.nomad")
}

resource "nomad_job" "ubuntu_upgrade" {
  jobspec = file("${path.module}/jobs/maintenance/ubuntu-upgrade.nomad")
}

resource "nomad_job" "nomad_gc" {
  jobspec = file("${path.module}/jobs/maintenance/nomad-gc.nomad")
}

resource "nomad_job" "docker_gc" {
  jobspec = file("${path.module}/jobs/maintenance/docker-gc.nomad")
}

resource "nomad_job" "journalctl_gc" {
  jobspec = file("${path.module}/jobs/maintenance/journalctl-gc.nomad")
}

resource "nomad_job" "postgres_backup" {
  jobspec = file("${path.module}/jobs/maintenance/postgres-backup.nomad")
}

resource "nomad_job" "prometheus" {
  jobspec = file("${path.module}/jobs/monitoring/prometheus.nomad")
}

resource "nomad_job" "prometheus_node_exporter" {
  jobspec = file("${path.module}/jobs/monitoring/prometheus-node-exporter.nomad")
}

resource "nomad_job" "prometheus_exporter_postgres" {
  jobspec = file("${path.module}/jobs/monitoring/prometheus-exporter-postgres.nomad")
}

resource "nomad_job" "nomad_config_backup" {
  jobspec = file("${path.module}/jobs/maintenance/nomad-config-backup.nomad")
}

resource "nomad_job" "prometheus_exporter_pihole" {
  jobspec = file("${path.module}/jobs/monitoring/prometheus-exporter-pihole.nomad")
}

resource "nomad_job" "speed_dial" {
  jobspec = file("${path.module}/jobs/apps/speed-dial.nomad")
}
