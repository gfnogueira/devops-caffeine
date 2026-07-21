#!/usr/bin/env bash
set -euo pipefail

echo "==> Tetragon DaemonSet"
kubectl -n kube-system get daemonset tetragon -o wide

echo
echo "==> Loaded TracingPolicies (cluster-scoped)"
kubectl get tracingpolicies

echo
echo "==> Loaded TracingPoliciesNamespaced"
kubectl get tracingpoliciesnamespaced -A

echo
echo "==> Recent events from one Tetragon pod (compact, last 50)"
POD=$(kubectl -n kube-system get pod -l app.kubernetes.io/name=tetragon -o jsonpath='{.items[0].metadata.name}')
kubectl -n kube-system exec "$POD" -c tetragon -- \
  tetra getevents -o compact --since 5m | tail -50
