#!/usr/bin/env bash
set -euo pipefail

COMPOSE="docker compose -f deploy/vps/docker-compose.yml"

echo "=== Containers ==="
$COMPOSE ps

echo "=== Hermes doctor ==="
$COMPOSE exec -T hermes hermes doctor

echo "=== Recent logs ==="
$COMPOSE logs --tail=80 hermes