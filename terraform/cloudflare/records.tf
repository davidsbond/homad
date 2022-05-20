resource "cloudflare_record" "homelab_wildcard" {
  for_each = var.nomad_client_ips

  name            = "*.homelab"
  value           = each.key
  type            = "A"
  ttl             = 3600
  zone_id         = data.cloudflare_zone.dsb_dev.id
  allow_overwrite = true
}

resource "cloudflare_record" "homelab" {
  for_each = var.nomad_client_ips

  name            = "homelab"
  value           = each.key
  type            = "A"
  ttl             = 3600
  zone_id         = data.cloudflare_zone.dsb_dev.id
  allow_overwrite = true
}

resource "cloudflare_record" "www_homelab" {
  for_each = var.nomad_client_ips

  name            = "www.homelab"
  value           = each.key
  type            = "A"
  ttl             = 3600
  zone_id         = data.cloudflare_zone.dsb_dev.id
  allow_overwrite = true
}

resource "cloudflare_record" "nas" {
  name            = "nas"
  value           = var.nas_ip
  type            = "A"
  ttl             = 3600
  zone_id         = data.cloudflare_zone.dsb_dev.id
  allow_overwrite = true
}

resource "cloudflare_record" "www_nas" {
  name            = "www.nas"
  value           = var.nas_ip
  type            = "A"
  ttl             = 3600
  zone_id         = data.cloudflare_zone.dsb_dev.id
  allow_overwrite = true
}
