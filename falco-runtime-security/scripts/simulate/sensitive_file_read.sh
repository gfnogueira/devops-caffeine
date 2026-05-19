#!/usr/bin/env bash
set -euo pipefail

IMAGE="${SIMULATE_TARGET_IMAGE:-alpine:3.20}"

echo "[simulate] reading /etc/shadow inside container"
docker run --rm --name falco-sim-secret "$IMAGE" sh -lc 'cat /etc/shadow || true; sleep 1'
