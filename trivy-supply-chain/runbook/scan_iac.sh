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

echo "==> Misconfig scan: Kubernetes manifests"
$TRIVY config \
  --severity HIGH,CRITICAL \
  --format table \
  targets/kubernetes

echo
echo "==> Misconfig scan: Terraform"
$TRIVY config \
  --severity MEDIUM,HIGH,CRITICAL \
  --format table \
  targets/terraform

echo
echo "==> SARIF aggregated for IaC"
$TRIVY config \
  --severity HIGH,CRITICAL \
  --format sarif \
  --output "$REPORTS_DIR/iac.sarif" \
  targets

echo "  wrote $REPORTS_DIR/iac.sarif"
