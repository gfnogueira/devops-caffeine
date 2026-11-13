#!/usr/bin/env bash
set -euo pipefail

iters=${1:-200}
host=${HOST:-http://localhost:8080}

for _ in $(seq 1 "$iters"); do
  case $((RANDOM % 10)) in
    0|1|2|3|4|5|6) curl -s -X POST "$host/pay" >/dev/null || true ;;
    7|8) curl -s -X POST "$host/refund" >/dev/null || true ;;
    9) curl -s "$host/healthz" >/dev/null || true ;;
  esac
  sleep 0.1
done
