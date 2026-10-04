#!/usr/bin/env bash
set -euo pipefail

port=${1:-12000}
echo "hubble-ui on http://localhost:${port}"
kubectl -n kube-system port-forward svc/hubble-ui "${port}:80"
