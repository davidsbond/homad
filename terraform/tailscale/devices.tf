data "tailscale_device" "nas" {
  name = "home-nas.davidsbond93.gmail.com"
}

data "tailscale_devices" "nomad_clients" {
  name_prefix = "homad-"
}
