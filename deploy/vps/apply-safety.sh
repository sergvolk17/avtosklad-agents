#!/usr/bin/env bash
set -euo pipefail

COMPOSE="docker compose -f deploy/vps/docker-compose.yml"

$COMPOSE run --rm hermes config set terminal.backend docker
$COMPOSE run --rm hermes config set terminal.cwd /workspace
$COMPOSE run --rm hermes config set skills.write_approval true
$COMPOSE run --rm hermes config set memory.write_approval true
$COMPOSE run --rm hermes config set security.allow_lazy_installs false
$COMPOSE run --rm hermes config set --force skills.external_dirs '["/opt/avtosklad-skills"]'

echo "Safety configuration applied."
echo "Verify with: $COMPOSE run --rm hermes doctor"