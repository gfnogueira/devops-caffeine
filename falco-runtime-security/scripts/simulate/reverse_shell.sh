#!/usr/bin/env bash
set -euo pipefail

IMAGE="${SIMULATE_TARGET_IMAGE:-alpine:3.20}"

echo "[simulate] reverse shell pattern (non-functional, pattern only)"
docker run --rm --name falco-sim-rsh "$IMAGE" sh -lc '
  echo "trying bash -i style invocation"
  sh -c "echo bash -i >/dev/tcp/127.0.0.1/4444" || true
  sleep 1
'
