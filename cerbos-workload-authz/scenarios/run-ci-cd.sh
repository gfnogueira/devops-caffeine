#!/usr/bin/env bash
# Same PDP, CI runner identity — staging goes through, prod from a PR is refused.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

PDP=${PDP:-http://localhost:3592}

for payload in checks/allow-ci-staging.json checks/deny-ci-prod-from-pr.json; do
  echo
  echo "--- $payload"
  curl -sS -X POST "$PDP/api/check/resources" \
    -H 'content-type: application/json' \
    -d @"$payload" | jq '.results[0] | {resource: .resource.id, actions: .actions}'
done
