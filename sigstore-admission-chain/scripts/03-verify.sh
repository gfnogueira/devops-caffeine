#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

for app in payment-api guestbook-ui; do
  ref="${REGISTRY}/${app}:${IMAGE_TAG}"
  echo "=== $ref"
  cosign verify --key cosign.pub --insecure-ignore-tlog "$ref" | jq '.[0].optional.subject // .[0].critical.image'
done
