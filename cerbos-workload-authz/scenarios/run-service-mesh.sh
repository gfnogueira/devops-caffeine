#!/usr/bin/env bash
# Walk the service-to-service decision matrix and print the effect for each call.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

PDP=${PDP:-http://localhost:3592}

for payload in checks/allow-same-env.json checks/deny-cross-env.json; do
  echo
  echo "--- $payload"
  curl -sS -X POST "$PDP/api/check/resources" \
    -H 'content-type: application/json' \
    -d @"$payload" | jq '.results[0] | {resource: .resource.id, actions: .actions}'
done
