#!/usr/bin/env bash
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SIMULATIONS=(
  shell_in_container.sh
  privileged_container.sh
  sensitive_mount.sh
  sensitive_file_read.sh
  crypto_miner_pattern.sh
  reverse_shell.sh
  persistence_attempt.sh
  ssh_authorized_keys.sh
)

for s in "${SIMULATIONS[@]}"; do
  echo "==> ${s}"
  bash "${HERE}/${s}"
  sleep 2
  echo
done

echo "All simulations dispatched."
