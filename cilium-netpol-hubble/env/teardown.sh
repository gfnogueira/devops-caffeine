#!/usr/bin/env bash
set -euo pipefail

CLUSTER=${CLUSTER:-netpol-lab}
kind delete cluster --name "$CLUSTER"
