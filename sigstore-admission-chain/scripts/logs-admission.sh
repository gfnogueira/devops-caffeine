#!/usr/bin/env bash
set -euo pipefail

ns=${NAMESPACE:-cosign-system}
tail=${1:-100}

kubectl -n "$ns" logs deploy/webhook --tail="$tail" --since=10m
