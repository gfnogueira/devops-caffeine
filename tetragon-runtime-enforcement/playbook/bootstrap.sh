#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

CLUSTER=${CLUSTER:-tetragon-poc}
TETRAGON_CHART_VERSION=${TETRAGON_CHART_VERSION:-1.2.0}

if ! kind get clusters | grep -qx "$CLUSTER"; then
  kind create cluster --name "$CLUSTER" --config kind.yaml
fi
kubectl config use-context "kind-$CLUSTER"

helm repo add cilium https://helm.cilium.io >/dev/null 2>&1 || true
helm repo update >/dev/null

helm upgrade --install tetragon cilium/tetragon \
  --namespace kube-system \
  --version "$TETRAGON_CHART_VERSION" \
  --set tetragon.exportFilename=/var/log/tetragon/events.json

kubectl -n kube-system rollout status daemonset/tetragon --timeout=120s
kubectl get nodes
