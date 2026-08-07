#!/usr/bin/env bash
# Dump the last decision-log entries from the local audit backend.
set -euo pipefail

n=${1:-20}
docker compose exec cerbos cerbos audit --kind=access --tail="$n" --raw
