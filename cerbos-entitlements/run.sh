#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

PDP=${PDP:-http://localhost:3592}
cmd=${1:-help}
shift || true

case "$cmd" in
  up)
    docker compose -f deploy/compose.yaml up -d
    sleep 2
    ;;
  down)
    docker compose -f deploy/compose.yaml down -v
    ;;
  ping)
    curl -sf "$PDP/_cerbos/health" && echo
    ;;
  check)
    payload=${1:?usage: ./run check <probe.json>}
    curl -sS -X POST "$PDP/api/check/resources" \
      -H 'content-type: application/json' \
      -d @"$payload" | jq '.results[0].actions'
    ;;
  test)
    docker compose -f deploy/compose.yaml exec -T cerbos \
      cerbos compile /plans --tests /plans
    ;;
  *)
    echo "usage: ./run {up|down|ping|check <probe>|test}" >&2
    exit 2
    ;;
esac
