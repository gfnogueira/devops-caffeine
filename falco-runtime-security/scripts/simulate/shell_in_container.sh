#!/usr/bin/env bash
set -euo pipefail

IMAGE="${SIMULATE_TARGET_IMAGE:-alpine:3.20}"

echo "[simulate] interactive shell in container"
docker run --rm -t --name falco-sim-shell "$IMAGE" sh -lc 'echo simulating-shell; sleep 1'
