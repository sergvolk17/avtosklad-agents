#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$HOME/avtosklad-agents}"
REPO_URL="https://github.com/sergvolk17/avtosklad-agents.git"

for cmd in git docker; do
  command -v "$cmd" >/dev/null || {
    echo "ERROR: $cmd is required before bootstrap."
    exit 2
  }
done

docker compose version >/dev/null || {
  echo "ERROR: Docker Compose v2 is required."
  exit 2
}

if [ ! -d "$REPO_DIR/.git" ]; then
  git clone "$REPO_URL" "$REPO_DIR"
else
  git -C "$REPO_DIR" pull --ff-only
fi

cd "$REPO_DIR"

if [ ! -f .env ]; then
  cp .env.example .env
  chmod 600 .env
  echo "Created .env with safe permissions."
fi

echo "Pulling stable Hermes image..."
docker compose -f deploy/vps/docker-compose.yml pull

echo "Run next:"
echo "docker compose -f deploy/vps/docker-compose.yml run --rm hermes setup --portal"
echo "bash deploy/vps/apply-safety.sh"
echo "docker compose -f deploy/vps/docker-compose.yml up -d"