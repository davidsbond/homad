data "tailscale_device" "nas" {
  name = "home-nas.tailnet-934e.ts.net"
}

data "tailscale_devices" "nomad_clients" {
  name_prefix = "homad-"
}
