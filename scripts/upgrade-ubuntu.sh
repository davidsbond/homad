#!/usr/bin/env bash
# This script is used on Nomad clients/servers to keep the underlying OS and its packages up-to-date. This script
# should be ran on a schedule by Nomad itself.

set -e

apt-get update -y
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get clean -y
