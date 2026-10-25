#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

pubkey=$(sed 's/^/          /' cosign.pub)
tmp=$(mktemp)
awk -v key="$pubkey" '
  /REPLACE_ME_WITH_cosign.pub/ { print key; next }
  { print }
' policies/warn-first.yaml > "$tmp"

kubectl apply -f "$tmp"
rm -f "$tmp"

kubectl apply -f workloads/

echo
echo "verdicts should show Warning on intruder, no Warning on signed pods"
kubectl get events --sort-by=.lastTimestamp | tail -20
