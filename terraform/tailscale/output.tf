# homad-0 is the server node, so it won't be serving any traffic, we want to get all tailscale devices whose
# names are prefixed with "homad-", filter out "homad-0" and return the first address for each node.
output "homelab_clients" {
  value = [
    for client in data.tailscale_devices.nomad_clients.devices : element(client.addresses, 0)
    if client.name != "homad-0.davidsbond93.gmail.com"
  ]
}

output "nas" {
  value = element(data.tailscale_device.nas.addresses, 0)
}
