#!/usr/bin/env bash
# Pulls the latest main, publishes the site, then runs the health check.
set -euo pipefail
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WEB_ROOT="${WEB_ROOT:-/var/www/qahub}"
cd "$REPO_DIR"
git pull --ff-only origin main
cp -r site/. "$WEB_ROOT"/
echo "Deployed commit: $(git rev-parse --short HEAD)"
bash scripts/health_check.sh
