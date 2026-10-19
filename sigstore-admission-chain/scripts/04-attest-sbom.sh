#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

for app in payment-api guestbook-ui; do
  ref="${REGISTRY}/${app}:${IMAGE_TAG}"
  sbom="${app}.sbom.json"

  trivy image --format cyclonedx --output "$sbom" "$ref"

  COSIGN_PASSWORD="" cosign attest \
    --key cosign.key \
    --predicate "$sbom" \
    --type cyclonedx \
    --tlog-upload=false \
    --yes "$ref"

  echo "attested: $ref with $sbom"
done
