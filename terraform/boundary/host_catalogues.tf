resource "boundary_host_catalog_static" "homelab" {
  name     = "homelab"
  scope_id = boundary_scope.homad.id
}

resource "boundary_host_set_static" "homelab" {
  host_catalog_id = boundary_host_catalog_static.homelab.id
  host_ids        = [for host in boundary_host_static.homelab : host.id]
}

resource "boundary_host_static" "homelab" {
  for_each        = var.homelab_servers
  name            = each.key
  host_catalog_id = boundary_host_catalog_static.homelab.id
  address         = each.key
}

