#!/usr/bin/env bash
set -euo pipefail

COMPOSE=(docker compose)

section() {
  echo "==> $1"
  shift
  "$@" || true
  echo
}

section "Compose services state" \
  "${COMPOSE[@]}" ps

section "Falco version and driver" \
  "${COMPOSE[@]}" exec -T falco falco --version

section "Loaded rule files" \
  "${COMPOSE[@]}" exec -T falco sh -lc 'ls -la /etc/falco/rules.d/'

section "Recent Falco daemon log" \
  "${COMPOSE[@]}" logs --tail=40 falco

section "Falcosidekick liveness" \
  curl -fsS http://localhost:2801/ping

section "Falcosidekick metrics summary" \
  bash -lc 'curl -fsS http://localhost:2801/metrics | grep -E "^falcosidekick_(outputs|inputs)_" | head -20'

section "Falcosidekick-UI reachability" \
  curl -fsS -o /dev/null -w "ui_http=%{http_code}\n" http://localhost:2802/

echo "Health check completed."
