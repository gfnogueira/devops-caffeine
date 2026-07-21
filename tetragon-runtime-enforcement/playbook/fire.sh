#!/usr/bin/env bash
# Apply one subject Job and wait for Tetragon to react.
# Usage: ./playbook/fire.sh <subject-yaml>
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
manifest=${1:?usage: fire.sh <subject-yaml>}

kubectl apply -f "$manifest"

job=$(yq '.metadata.name' "$manifest")
ns=$(yq '.metadata.namespace' "$manifest")

kubectl -n "$ns" wait --for=condition=complete --timeout=30s "job/$job" \
  || kubectl -n "$ns" get pods -l job-name="$job"
