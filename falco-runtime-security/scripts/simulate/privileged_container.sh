#!/usr/bin/env bash
set -euo pipefail

IMAGE="${SIMULATE_TARGET_IMAGE:-alpine:3.20}"

echo "[simulate] privileged container started"
docker run --rm --privileged --name falco-sim-priv "$IMAGE" sh -lc 'id; sleep 2'
