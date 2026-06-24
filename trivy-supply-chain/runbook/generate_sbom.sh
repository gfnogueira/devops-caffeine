#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

REPORTS_DIR=${REPORTS_DIR:-reports}
mkdir -p "$REPORTS_DIR"

TRIVY="docker run --rm \
  -v ${PWD}:/work \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${HOME}/.cache/trivy:/root/.cache/trivy \
  -w /work \
  aquasec/trivy:0.55.0"

IMAGE="${IMAGE:-trivy-poc/web-app:dirty}"

echo "==> CycloneDX SBOM for $IMAGE"
$TRIVY image \
  --format cyclonedx \
  --output "$REPORTS_DIR/${IMAGE//[\/:]/_}.cyclonedx.json" \
  "$IMAGE"

echo "==> SPDX SBOM for $IMAGE"
$TRIVY image \
  --format spdx-json \
  --output "$REPORTS_DIR/${IMAGE//[\/:]/_}.spdx.json" \
  "$IMAGE"

echo
echo "Generated SBOMs:"
ls -1 "$REPORTS_DIR"/*.cyclonedx.json "$REPORTS_DIR"/*.spdx.json 2>/dev/null
