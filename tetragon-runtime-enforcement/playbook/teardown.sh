#!/usr/bin/env bash
set -euo pipefail

CLUSTER=${CLUSTER:-tetragon-poc}
kind delete cluster --name "$CLUSTER"
