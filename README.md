# homad

This repository contains all the configuration of my [HashiCorp Nomad](https://nomadproject.io) deployment in my
home server-rack. It is deployed in a high-availability configuration using both [HashiCorp Vault](https://www.vaultproject.io/)
and [HashiCorp Consul](https://www.consul.io/).

The cluster itself runs on [Ubuntu](https://ubuntu.com/) and is made available to me via the [Tailscale](https://tailscale.com/) VPN.

Everything within this repository is managed using [Terraform](https://www.terraform.io/), including deployment of
workloads in Nomad. Terraform source files are organised by provider within the [terraform](./terraform) directory.

## Workloads

To see all my Nomad job specifications, check the [jobs](terraform/nomad/jobs) directory.

Within my Nomad cluster, I run the following services:

* [Bitwarden](https://bitwarden.com/) - Password manager
* [Boundary](https://www.boundaryproject.io/) - User identity management
* [Grafana](https://grafana.com/) - For all the dashboards
* [Home Assistant](https://www.home-assistant.io/) - IoT integration suite that allows me to manage & automate my smart devices
* [Minio](https://min.io/) - S3 compaptible object storage.
* [PiHole](https://pi-hole.net/) - DNS & Adblocker that I use on my networked devices at home
* [Postgres](https://www.postgresql.org/) - SQL database for services that need one
* [Traefik](https://traefik.io/) - Reverse proxy & load balancer that allows me to access my applications and issue TLS certificates

### CSI

Workloads that require persistent storage can use volumes mounted via NFS using the [rocketduck CSI driver](https://gitlab.com/rocketduck/csi-plugin-nfs).
Volume specifications are located [here](terraform/nomad/volumes.tf).

## CI

Merges to the `master` branch will automatically plan and apply changes to terraform files by first connecting the
GitHub action to my Tailscale tailnet. For pull requests, a plan is performed which can be checked within the
GitHub action log.

## Upgrades

Keeping Nomad & Ubuntu up-to-date is done by leveraging Nomad's periodic jobs & the [raw_exec](https://www.nomadproject.io/docs/drivers/raw_exec)
driver. On a daily basis [this job](terraform/nomad/jobs/maintenance/ubuntu-upgrade.nomad) is ran which will keep Ubuntu's packages
and distribution up-to-date.
