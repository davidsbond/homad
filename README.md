# homad

This repository contains all the configuration of my [HashiCorp Nomad](https://nomadproject.io) deployment in my
home server-rack. It is deployed in a high-availability configuration using both [HashiCorp Vault](https://www.vaultproject.io/)
and [HashiCorp Consul](https://www.consul.io/).

Everything within this repository is managed using [Terraform](https://www.terraform.io/), including deployment of
workloads in Nomad. Terraform source files are organised by provider within the [terraform](./terraform) directory.

## Workloads

To see all my Nomad job specifications, check the [jobs](terraform/nomad/jobs) directory.

Within my Nomad cluster, I run the following services:

* [Bitwarden](https://bitwarden.com/) - Password manager
* [Home Assistant](https://www.home-assistant.io/) - IoT integration suite that allows me to manage & automate my smart devices
* [PiHole](https://pi-hole.net/) - DNS & Adblocker that I use on my networked devices at home
* [Postgres](https://www.postgresql.org/) - SQL database for services that need one
* [Traefik](https://traefik.io/) - Reverse proxy & load balancer that allows me to access my applications and issue TLS certificates

## CI

Merges to the `master` branch will automatically plan and apply changes to terraform files by first connecting the
GitHub action to my [Tailscale](https://tailscale.com/) tailnet. For pull requests, a plan is performed which can be checked within the
GitHub action log.
