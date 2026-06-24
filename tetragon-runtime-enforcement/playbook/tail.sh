#!/usr/bin/env bash
set -euo pipefail

NS=${NS:-evaluation}
NODE=${NODE:-}

POD=$(kubectl -n kube-system get pod -l app.kubernetes.io/name=tetragon \
  ${NODE:+--field-selector spec.nodeName=$NODE} \
  -o jsonpath='{.items[0].metadata.name}')

# Stream events filtered to the evaluation namespace via tetra inside the pod.
kubectl -n kube-system exec -i "$POD" -c tetragon -- \
  tetra getevents -o compact --namespace "$NS"
