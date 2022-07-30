resource "nomad_external_volume" "home_assistant" {
  type         = "csi"
  plugin_id    = "nfs"
  volume_id    = "home-assistant"
  name         = "home-assistant"
  capacity_min = "10M"
  capacity_max = "1Gi"

  capability {
    access_mode     = "multi-node-multi-writer"
    attachment_mode = "file-system"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "nomad_external_volume" "bitwarden" {
  type         = "csi"
  plugin_id    = "nfs"
  volume_id    = "bitwarden"
  name         = "bitwarden"
  capacity_min = "10M"
  capacity_max = "1Gi"

  capability {
    access_mode     = "multi-node-multi-writer"
    attachment_mode = "file-system"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "nomad_external_volume" "postgres" {
  type         = "csi"
  plugin_id    = "nfs"
  volume_id    = "postgres"
  name         = "postgres"
  capacity_min = "10M"
  capacity_max = "1Gi"

  capability {
    access_mode     = "multi-node-multi-writer"
    attachment_mode = "file-system"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "nomad_external_volume" "minio" {
  type         = "csi"
  plugin_id    = "nfs"
  volume_id    = "minio"
  name         = "minio"
  capacity_min = "10M"
  capacity_max = "100Gi"

  capability {
    access_mode     = "multi-node-multi-writer"
    attachment_mode = "file-system"
  }

  lifecycle {
    prevent_destroy = false
  }
}
