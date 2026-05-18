#!/usr/bin/env bash
set -euo pipefail

SIDEKICK_URL="${SIDEKICK_URL:-http://localhost:2801}"

post_event() {
  local priority="$1"
  local rule="$2"
  local output="$3"
  curl -fsS -X POST "${SIDEKICK_URL}/" \
    -H 'Content-Type: application/json' \
    --data "{
      \"output\": \"${output}\",
      \"priority\": \"${priority}\",
      \"rule\": \"${rule}\",
      \"time\": \"$(date -u +"%Y-%m-%dT%H:%M:%S.000000Z")\",
      \"output_fields\": {\"user.name\": \"poc-test\", \"proc.cmdline\": \"synthetic\"},
      \"source\": \"syscall\",
      \"tags\": [\"poc\", \"synthetic\"]
    }"
  echo
}

echo "==> Sending synthetic events through Falcosidekick"
post_event "Debug"    "Synthetic debug event"    "Synthetic debug output"
post_event "Warning"  "Synthetic warning event"  "Synthetic warning output"
post_event "Critical" "Synthetic critical event" "Synthetic critical output"

echo
echo "==> Sidekick metrics snapshot"
curl -fsS "${SIDEKICK_URL}/metrics" | grep -E "^falcosidekick_" | head -20 || true

echo
echo "Output routing test completed."
