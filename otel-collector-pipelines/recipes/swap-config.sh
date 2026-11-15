#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

variant=${1:-baseline}
case "$variant" in
  baseline|with-processors) ;;
  *) echo "variant must be baseline or with-processors" >&2; exit 1 ;;
esac

sed -i.bak -E "s#\./otelcol/[^:]+:/etc/otelcol/config\.yaml#./otelcol/${variant}.yaml:/etc/otelcol/config.yaml#" compose.yaml
rm -f compose.yaml.bak

echo "pointed compose.yaml at otelcol/${variant}.yaml"
docker compose up -d otelcol
