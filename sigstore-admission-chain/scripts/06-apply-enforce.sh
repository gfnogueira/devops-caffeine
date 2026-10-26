#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

kubectl delete clusterimagepolicy registry-signed-warn --ignore-not-found

pubkey=$(sed 's/^/          /' cosign.pub)
for pol in policies/require-signature.yaml policies/require-sbom-attest.yaml; do
  tmp=$(mktemp)
  awk -v key="$pubkey" '
    /REPLACE_ME_WITH_cosign.pub/ { print key; next }
    { print }
  ' "$pol" > "$tmp"
  kubectl apply -f "$tmp"
  rm -f "$tmp"
done

echo
echo "retry the unsigned pod now; the admission response carries the reason:"
kubectl delete pod intruder --ignore-not-found
kubectl apply -f workloads/intruder-unsigned.yaml || true
