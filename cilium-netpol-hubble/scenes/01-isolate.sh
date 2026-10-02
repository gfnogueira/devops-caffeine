#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

kubectl apply -f netpol/default-deny.yaml

echo
echo "intruder probe should fail now:"
kubectl -n intruder exec deploy/probe -- \
  curl -sS -m 3 -o /dev/null -w "%{http_code}\n" http://api.backend/ || true

echo
echo "frontend probe should also fail (no allow yet):"
kubectl -n frontend exec deploy/webclient -- \
  curl -sS -m 3 -o /dev/null -w "%{http_code}\n" http://api.backend/ || true
