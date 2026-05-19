#!/usr/bin/env bash
set -euo pipefail

IMAGE="${SIMULATE_TARGET_IMAGE:-alpine:3.20}"

echo "[simulate] executing fake binary named xmrig"
docker run --rm --name falco-sim-miner "$IMAGE" sh -lc '
  cp /bin/true /tmp/xmrig
  chmod +x /tmp/xmrig
  /tmp/xmrig --help || true
'
