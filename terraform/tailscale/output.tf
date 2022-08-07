output "homelab_clients" {
  value = [
    for client in data.tailscale_devices.nomad_clients.devices : element(client.addresses, 0)
  ]
}

output "homelab_servers" {
  value = [for client in data.tailscale_devices.nomad_clients.devices : element(client.addresses, 0)]
}

output "nas" {
  value = element(data.tailscale_device.nas.addresses, 0)
}
