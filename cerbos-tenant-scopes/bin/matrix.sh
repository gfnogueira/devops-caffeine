#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

for req in requests/*.json; do
  name=$(basename "$req" .json)
  printf '\n=== %s\n' "$name"
  curl -sS -X POST http://localhost:3592/api/check/resources \
    -H 'content-type: application/json' \
    -d @"$req" | jq -c '.results[0].actions'
done
