#!/usr/bin/env bash
set -euo pipefail

IMAGE="${SIMULATE_TARGET_IMAGE:-alpine:3.20}"

echo "[simulate] writing a cron entry inside container"
docker run --rm --name falco-sim-persist "$IMAGE" sh -lc '
  mkdir -p /etc/cron.d
  echo "* * * * * root /tmp/payload.sh" > /etc/cron.d/poc-persistence
  cat /etc/cron.d/poc-persistence
'
