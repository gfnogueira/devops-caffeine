#!/usr/bin/env bash
set -euo pipefail

ns=${1:-backend}
last=${2:-50}

kubectl -n kube-system port-forward svc/hubble-relay 4245:80 >/dev/null 2>&1 &
pf=$!
trap 'kill $pf 2>/dev/null || true' EXIT
sleep 1

hubble observe --server localhost:4245 \
  --namespace "$ns" \
  --last "$last" \
  --output compact
