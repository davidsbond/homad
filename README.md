# homad

This repository contains all the configuration of my [HashiCorp Nomad](https://nomadproject.io) deployment in my
home server-rack. It is deployed in a high-availability configuration using both [HashiCorp Vault](https://www.vaultproject.io/) 
and [HashiCorp Consul](https://www.consul.io/).

Everything within this repository is managed using [Terraform](https://www.terraform.io/), including deployment of 
workloads in Nomad.

## Workloads

To see all my Nomad job specifications, check the [jobs](terraform/nomad/jobs) directory.

Within my Nomad cluster, I run the following services:

* [Traefik](https://traefik.io/) - Reverse proxy & load balancer that allows me to access my applications and issue TLS certificates
* [PiHole](https://pi-hole.net/) - DNS & Adblocker that I use on my networked devices at home
* [Home Assistant](https://www.home-assistant.io/) - IoT integration suite that allows me to manage & automate my smart devices
* [Bitwarden](https://bitwarden.com/) - Password manager
