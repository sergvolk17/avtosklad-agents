#!/usr/bin/env bash
set -euo pipefail

echo "АвтоСклад preflight"

test -f docker-compose.yml || { echo "ERROR: run from project root"; exit 1; }
test -f AGENTS.md || { echo "ERROR: AGENTS.md missing"; exit 1; }
test -d skills || { echo "ERROR: skills/ missing"; exit 1; }

if [ -f .env ]; then
  perms=$(stat -c '%a' .env 2>/dev/null || true)
  echo ".env permissions: ${perms:-unknown}"
else
  echo "NOTICE: .env not created yet"
fi

echo "Checking for obvious secrets accidentally committed..."
if grep -RIE --exclude='.env' --exclude-dir='.git' '(ghp_[A-Za-z0-9]+|sk-[A-Za-z0-9_-]{16,}|BEGIN (RSA |OPENSSH )?PRIVATE KEY|password[[:space:]]*=[[:space:]]*[^#[:space:]]+)' . ; then
  echo "ERROR: possible secret found; review before commit"
  exit 2
fi

echo "Preflight OK"
