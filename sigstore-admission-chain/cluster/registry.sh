#!/usr/bin/env bash
set -euo pipefail

CLUSTER=${CLUSTER:-admission-chain}
REGISTRY=registry.local

docker container inspect "$REGISTRY" >/dev/null 2>&1 || \
  docker run -d --restart=always -p 5000:5000 --name "$REGISTRY" registry:2.8.3

docker network connect kind "$REGISTRY" 2>/dev/null || true

for node in $(kind get nodes --name "$CLUSTER"); do
  docker exec "$node" sh -c "echo '127.0.0.1 $REGISTRY' >> /etc/hosts" || true
done

echo "registry up on $REGISTRY:5000"
