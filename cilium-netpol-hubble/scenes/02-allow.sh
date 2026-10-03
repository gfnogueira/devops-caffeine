#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

kubectl apply -f netpol/allow-frontend-to-backend.yaml

echo
echo "frontend reaches api now:"
kubectl -n frontend exec deploy/webclient -- \
  curl -sS -m 3 -o /dev/null -w "%{http_code}\n" http://api.backend/

echo
echo "intruder still blocked:"
kubectl -n intruder exec deploy/probe -- \
  curl -sS -m 3 -o /dev/null -w "%{http_code}\n" http://api.backend/ || true
