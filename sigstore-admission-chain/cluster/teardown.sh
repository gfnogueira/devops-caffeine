#!/usr/bin/env bash
set -euo pipefail

CLUSTER=${CLUSTER:-admission-chain}
REGISTRY=registry.local

kind delete cluster --name "$CLUSTER" || true
docker rm -f "$REGISTRY" 2>/dev/null || true
