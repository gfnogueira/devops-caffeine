#!/usr/bin/env bash
set -euo pipefail

IMAGE="${SIMULATE_TARGET_IMAGE:-alpine:3.20}"

echo "[simulate] modifying authorized_keys inside container"
docker run --rm --name falco-sim-sshkey "$IMAGE" sh -lc '
  mkdir -p /root/.ssh
  echo "ssh-rsa AAAAFAKEKEY poc-attacker" >> /root/.ssh/authorized_keys
  cat /root/.ssh/authorized_keys
'
