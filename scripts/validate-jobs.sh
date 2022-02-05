#!/usr/bin/env bash

set -e

for JOB in $(find . -type f -name '*.nomad' | sort | uniq)  ; do
  nomad job validate "$JOB"
done
