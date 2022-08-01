#!/usr/bin/env bash
# This script is used to validate all Nomad jobs stored within this repository. When available, the NOMAD_ADDR
# environment variable should be set to allow validation of driver configuration. Driver configuration is only
# available if the Nomad agent is also available.

set -e

for JOB in $(find . -type f -name '*.nomad' | sort | uniq)  ; do
  nomad job validate "$JOB"
done
