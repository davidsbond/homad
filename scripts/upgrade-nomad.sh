#!/usr/bin/env bash
# This script checks the locally installed nomad version against the latest upstream version. If a difference is
# detected, the latest version will be downloaded, installed and the nomad service restarted.

set -e

LATEST_VERSION=$(curl -s "https://api.releases.hashicorp.com/v1/releases/nomad?license_class=oss" | jq -r '.[0].version')
NOMAD_ADDR=$(tailscale ip -4)
CURRENT_VERSION=$(curl -s "http://$NOMAD_ADDR:4646/v1/agent/self" | jq -r '.config.Version.Version')

if [ "$LATEST_VERSION" = "$CURRENT_VERSION" ]; then
  echo "Nomad is up-to-date"
  exit 0
fi

echo "Updating nomad to ${LATEST_VERSION}"

ARCHIVE_NAME=nomad_"${LATEST_VERSION}"_linux_arm64.zip
DOWNLOAD_URL=https://releases.hashicorp.com/nomad/"$LATEST_VERSION"/"$ARCHIVE_NAME"

curl -s "$DOWNLOAD_URL" --output "$ARCHIVE_NAME"
unzip -qq "$ARCHIVE_NAME"
rm "$ARCHIVE_NAME"

NOMAD_LOCATION=$(which nomad)
mv ./nomad "$NOMAD_LOCATION"

echo "Restarting nomad"
systemctl restart nomad.service
