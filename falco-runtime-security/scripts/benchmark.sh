#!/usr/bin/env bash
set -euo pipefail

ITERATIONS="${BENCH_ITERATIONS:-10}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG="$(docker compose exec -T falco sh -lc 'echo /var/log/falco/falco-events.log')"

bench_one() {
  local label="$1"
  local script="$2"
  local rule="$3"
  local sample=0
  local total_ms=0

  echo "==> ${label} (x${ITERATIONS})"
  for _ in $(seq 1 "$ITERATIONS"); do
    local start_ms end_ms
    start_ms=$(date +%s%3N)
    bash "${HERE}/simulate/${script}" >/dev/null 2>&1 || true
    while true; do
      if docker compose exec -T falco grep -F "\"${rule}\"" "${LOG}" >/dev/null 2>&1; then
        end_ms=$(date +%s%3N)
        break
      fi
      if (( $(date +%s%3N) - start_ms > 15000 )); then
        end_ms=0
        break
      fi
      sleep 0.05
    done
    if [[ "$end_ms" -gt 0 ]]; then
      total_ms=$(( total_ms + end_ms - start_ms ))
      sample=$(( sample + 1 ))
    fi
  done

  if [[ "$sample" -gt 0 ]]; then
    echo "  detected ${sample}/${ITERATIONS} runs; avg detection latency: $(( total_ms / sample )) ms"
  else
    echo "  no detections captured within window"
  fi
  echo
}

bench_one "shell in container"   shell_in_container.sh   "Interactive shell spawned in container"
bench_one "privileged container" privileged_container.sh "Privileged container started"
bench_one "sensitive file read"  sensitive_file_read.sh  "Read of sensitive secret file"

echo "Benchmark completed."
