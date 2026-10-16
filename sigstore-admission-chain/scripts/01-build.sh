#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

for app in payment-api guestbook-ui; do
  ref="${REGISTRY}/${app}:${IMAGE_TAG}"
  docker build -t "$ref" "images/$app"
  docker push "$ref"
  echo "pushed: $ref"
done
