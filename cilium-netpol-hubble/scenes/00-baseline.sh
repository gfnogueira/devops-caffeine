#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "no policies applied, both namespaces should reach api:"
echo

echo "frontend:"
kubectl -n frontend exec deploy/webclient -- \
  curl -sS -m 3 -o /dev/null -w "%{http_code}\n" http://api.backend/

echo "intruder:"
kubectl -n intruder exec deploy/probe -- \
  curl -sS -m 3 -o /dev/null -w "%{http_code}\n" http://api.backend/
