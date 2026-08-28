#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "=== policy tests"
docker compose exec -T cerbos cerbos compile /policies --tests /policies

echo
echo "=== tool gate matrix"
python -m scripts.demo_tool_gate

echo
echo "=== rag filter matrix"
python -m scripts.demo_rag_filter
