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

echo "==> Vulnerable dependencies in filesystem target"
$TRIVY fs \
  --severity HIGH,CRITICAL \
  --scanners vuln \
  --format table \
  targets/filesystem-sample

echo
echo "==> License audit"
$TRIVY fs \
  --scanners license \
  --format table \
  targets/filesystem-sample

echo
echo "==> SBOM-friendly JSON for filesystem"
$TRIVY fs \
  --format json \
  --output "$REPORTS_DIR/filesystem.json" \
  targets/filesystem-sample

echo "  wrote $REPORTS_DIR/filesystem.json"
