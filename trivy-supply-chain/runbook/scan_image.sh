#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

REPORTS_DIR=${REPORTS_DIR:-reports}
mkdir -p "$REPORTS_DIR"

# Build the vulnerable target once so vuln scans operate on a real image, not
# just the Dockerfile.
docker build -f targets/dockerfiles/Dockerfile.web-app -t trivy-poc/web-app:dirty targets/dockerfiles >/dev/null

TRIVY="docker run --rm \
  -v ${PWD}:/work \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${HOME}/.cache/trivy:/root/.cache/trivy \
  -w /work \
  aquasec/trivy:0.55.0"

echo "==> Vulnerability scan: trivy-poc/web-app:dirty"
$TRIVY image \
  --severity HIGH,CRITICAL \
  --ignore-unfixed \
  --format table \
  trivy-poc/web-app:dirty

echo
echo "==> SARIF output for code scanning"
$TRIVY image \
  --severity HIGH,CRITICAL \
  --format sarif \
  --output "$REPORTS_DIR/image-web-app.sarif" \
  trivy-poc/web-app:dirty

echo "  wrote $REPORTS_DIR/image-web-app.sarif"
