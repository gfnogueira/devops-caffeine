#!/usr/bin/env bash
set -euo pipefail

NAMESPACE=${NAMESPACE:-cosign-system}
VERSION=${VERSION:-0.11.1}

helm repo add sigstore https://sigstorestack.github.io/helm-charts >/dev/null 2>&1 || true
helm repo update sigstore >/dev/null

helm upgrade --install policy-controller sigstore/policy-controller \
  --version "$VERSION" \
  --namespace "$NAMESPACE" \
  --create-namespace \
  --set webhook.failurePolicy=Ignore

kubectl -n "$NAMESPACE" rollout status deploy/webhook --timeout=180s

kubectl label namespace default policy.sigstore.dev/include=true --overwrite
echo "policy-controller armed on namespace: default"
