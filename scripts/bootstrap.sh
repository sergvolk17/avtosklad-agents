#!/usr/bin/env bash
set -euo pipefail

COMPOSE=${COMPOSE:-docker compose}

echo "[1/7] Hermes status"
$COMPOSE run --rm hermes doctor || true

echo "[2/7] Keep terminal inside the Hermes container"
$COMPOSE run --rm hermes config set terminal.backend local

echo "[3/7] Restrict working directory"
$COMPOSE run --rm hermes config set terminal.cwd /workspace

echo "[4/7] Require approval for skill writes"
$COMPOSE run --rm hermes config set skills.write_approval true

echo "[5/7] Require approval for memory writes"
$COMPOSE run --rm hermes config set memory.write_approval true

echo "[6/7] Disable lazy package installs"
$COMPOSE run --rm hermes config set security.allow_lazy_installs false

echo "[7/7] Register project skills directory"
$COMPOSE run --rm hermes config set --force skills.external_dirs '["/opt/avtosklad-skills"]'

echo "Bootstrap complete. Run: docker compose up -d"