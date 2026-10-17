#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

if [ ! -f cosign.key ]; then
  COSIGN_PASSWORD="" cosign generate-key-pair
fi

for app in payment-api guestbook-ui; do
  ref="${REGISTRY}/${app}:${IMAGE_TAG}"
  COSIGN_PASSWORD="" cosign sign --key cosign.key --tlog-upload=false --yes "$ref"
  echo "signed: $ref"
done
