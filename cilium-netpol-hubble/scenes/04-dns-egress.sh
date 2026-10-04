#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

kubectl apply -f netpol/dns-aware-egress.yaml

echo
echo "frontend can resolve and reach api by FQDN:"
kubectl -n frontend exec deploy/webclient -- \
  curl -sS -m 3 -o /dev/null -w "%{http_code}\n" http://api.backend.svc.cluster.local/

echo
echo "frontend can reach pypi (allow-listed FQDN):"
kubectl -n frontend exec deploy/webclient -- \
  curl -sS -m 5 -o /dev/null -w "%{http_code}\n" https://pypi.org/simple/ || true

echo
echo "frontend cannot reach github (not on the FQDN list):"
kubectl -n frontend exec deploy/webclient -- \
  curl -sS -m 5 -o /dev/null -w "%{http_code}\n" https://github.com/ || true
