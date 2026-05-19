#!/usr/bin/env bash
set -euo pipefail

IMAGE="${SIMULATE_TARGET_IMAGE:-alpine:3.20}"

echo "[simulate] container with sensitive host mount"
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock --name falco-sim-mount "$IMAGE" \
  sh -lc 'ls -la /var/run/docker.sock || true; sleep 2'
