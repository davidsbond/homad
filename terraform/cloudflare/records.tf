locals {
  homad_ips = [
    "192.168.0.18"
  ]
}

resource "cloudflare_record" "homad_wildcard" {
  for_each = toset(local.homad_ips)

  name    = "*.homad"
  value   = each.key
  type    = "A"
  ttl     = 3600
  zone_id = data.cloudflare_zone.dsb_dev.id
}

resource "cloudflare_record" "homad" {
  for_each = toset(local.homad_ips)

  name    = "homad"
  value   = each.key
  type    = "A"
  ttl     = 3600
  zone_id = data.cloudflare_zone.dsb_dev.id
}

resource "cloudflare_record" "www_homad" {
  for_each = toset(local.homad_ips)

  name    = "www.homad"
  value   = each.key
  type    = "A"
  ttl     = 3600
  zone_id = data.cloudflare_zone.dsb_dev.id
}
