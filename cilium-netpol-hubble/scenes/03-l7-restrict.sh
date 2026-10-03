#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

kubectl delete networkpolicy allow-frontend-to-api -n backend --ignore-not-found
kubectl apply -f netpol/l7-http-method.yaml

echo
echo "GET on / is allowed:"
kubectl -n frontend exec deploy/webclient -- \
  curl -sS -m 3 -o /dev/null -w "%{http_code}\n" http://api.backend/

echo
echo "POST on / is blocked by L7 rule:"
kubectl -n frontend exec deploy/webclient -- \
  curl -sS -m 3 -X POST -o /dev/null -w "%{http_code}\n" http://api.backend/ || true

echo
echo "GET on /other is blocked (path mismatch):"
kubectl -n frontend exec deploy/webclient -- \
  curl -sS -m 3 -o /dev/null -w "%{http_code}\n" http://api.backend/other || true
