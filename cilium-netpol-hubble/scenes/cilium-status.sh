#!/usr/bin/env bash
set -euo pipefail

pod=$(kubectl -n kube-system get pod -l k8s-app=cilium -o jsonpath='{.items[0].metadata.name}')
kubectl -n kube-system exec "$pod" -c cilium-agent -- cilium status --brief
echo
kubectl -n kube-system exec "$pod" -c cilium-agent -- cilium endpoint list -o json \
  | jq -r '.[] | [.id, .labels.realized.security[0], .status.networking.addressing[0].ipv4] | @tsv'
