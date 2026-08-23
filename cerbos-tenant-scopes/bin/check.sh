#!/usr/bin/env bash
set -euo pipefail

payload=${1:?usage: check.sh <request.json>}

curl -sS -X POST http://localhost:3592/api/check/resources \
  -H 'content-type: application/json' \
  -d @"$payload" | jq '.results[0].actions'
