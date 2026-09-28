#!/usr/bin/env bash
set -euo pipefail

CLUSTER=${CLUSTER:-netpol-lab}
VERSION=${VERSION:-1.16.3}

kind create cluster --config "$(dirname "$0")/kind.yaml"

helm repo add cilium https://helm.cilium.io/ >/dev/null
helm repo update >/dev/null

helm install cilium cilium/cilium --version "$VERSION" \
  --namespace kube-system \
  --set kubeProxyReplacement=true \
  --set k8sServiceHost="${CLUSTER}-control-plane" \
  --set k8sServicePort=6443 \
  --set hubble.enabled=true \
  --set hubble.relay.enabled=true \
  --set hubble.ui.enabled=true

kubectl -n kube-system rollout status ds/cilium --timeout=180s
kubectl -n kube-system rollout status deploy/hubble-relay --timeout=180s
