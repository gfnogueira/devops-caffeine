#!/usr/bin/env bash
set -euo pipefail

n=${1:-20}
docker compose exec -T cerbos cerbos audit --kind=access --tail="$n" --raw
