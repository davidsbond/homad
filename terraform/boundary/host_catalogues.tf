resource "boundary_host_catalog" "homelab" {
  name     = "homelab"
  type     = "static"
  scope_id = boundary_scope.homad.id
}

resource "boundary_host_set" "homelab" {
  name            = "homelab"
  host_catalog_id = boundary_host_catalog.homelab.id
  type            = "static"
  host_ids        = [for host in boundary_host.homelab : host.id]
}

resource "boundary_host" "homelab" {
  for_each        = var.homelab_servers
  name            = each.key
  host_catalog_id = boundary_host_catalog.homelab.id
  type            = "static"
  address         = each.key
}

