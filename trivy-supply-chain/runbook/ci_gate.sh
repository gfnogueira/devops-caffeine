#!/usr/bin/env bash
# Aggregated gate for CI. Exits non-zero on any blocker finding.
# Tunables via env:
#   FAIL_SEVERITY  default HIGH,CRITICAL
#   IMAGE_REF      image to scan; required when GATE_IMAGE=1
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

REPORTS_DIR=${REPORTS_DIR:-reports}
mkdir -p "$REPORTS_DIR"

FAIL_SEVERITY=${FAIL_SEVERITY:-HIGH,CRITICAL}
GATE_IMAGE=${GATE_IMAGE:-0}
GATE_IAC=${GATE_IAC:-1}
GATE_SECRETS=${GATE_SECRETS:-1}
IMAGE_REF=${IMAGE_REF:-}

TRIVY_BASE="docker run --rm \
  -v ${PWD}:/work \
  -v ${HOME}/.cache/trivy:/root/.cache/trivy \
  -w /work \
  aquasec/trivy:0.55.0"

EXIT=0

if [[ "$GATE_IAC" == "1" ]]; then
  echo "==> Gate: IaC misconfig"
  $TRIVY_BASE config \
    --severity "$FAIL_SEVERITY" \
    --exit-code 1 \
    --format table \
    targets || EXIT=1
fi

if [[ "$GATE_SECRETS" == "1" ]]; then
  echo
  echo "==> Gate: secret detection"
  $TRIVY_BASE fs \
    --scanners secret \
    --severity "$FAIL_SEVERITY" \
    --exit-code 1 \
    --format table \
    targets || EXIT=1
fi

if [[ "$GATE_IMAGE" == "1" ]]; then
  : "${IMAGE_REF:?IMAGE_REF must be set when GATE_IMAGE=1}"
  echo
  echo "==> Gate: image vulnerabilities ($IMAGE_REF)"
  $TRIVY_BASE_WITH_DOCKER="docker run --rm \
    -v ${PWD}:/work \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${HOME}/.cache/trivy:/root/.cache/trivy \
    -w /work \
    aquasec/trivy:0.55.0"
  $TRIVY_BASE_WITH_DOCKER image \
    --severity "$FAIL_SEVERITY" \
    --ignore-unfixed \
    --exit-code 1 \
    --format table \
    "$IMAGE_REF" || EXIT=1
fi

echo
if [[ "$EXIT" -ne 0 ]]; then
  echo "Gate failed."
else
  echo "Gate passed."
fi
exit "$EXIT"
