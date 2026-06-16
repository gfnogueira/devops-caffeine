#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

REPORTS_DIR=${REPORTS_DIR:-reports}
mkdir -p "$REPORTS_DIR"

TRIVY="docker run --rm \
  -v ${PWD}:/work \
  -v ${HOME}/.cache/trivy:/root/.cache/trivy \
  -w /work \
  aquasec/trivy:0.55.0"

echo "==> Secret scan across every target"
$TRIVY fs \
  --scanners secret \
  --severity LOW,MEDIUM,HIGH,CRITICAL \
  --format table \
  targets

echo
echo "==> SARIF for the secret findings"
$TRIVY fs \
  --scanners secret \
  --format sarif \
  --output "$REPORTS_DIR/secrets.sarif" \
  targets

echo "  wrote $REPORTS_DIR/secrets.sarif"
