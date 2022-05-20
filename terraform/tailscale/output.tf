output "homelab_clients" {
  value = [
    element(data.tailscale_device.homad_1.addresses, 0),
    element(data.tailscale_device.homad_2.addresses, 0),
    element(data.tailscale_device.homad_3.addresses, 0),
  ]
}
