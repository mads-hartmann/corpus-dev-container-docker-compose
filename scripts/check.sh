#!/usr/bin/env bash
set -euo pipefail

port="${APP_PORT:-8000}"

cleanup() {
  docker compose down -v --remove-orphans >/dev/null 2>&1 || true
}
trap cleanup EXIT

docker compose config --quiet
docker compose build
docker compose run --rm --no-deps web python -m py_compile app.py
docker compose up -d --wait

response=""
for _ in $(seq 1 20); do
  if response="$(curl -fsS "http://localhost:${port}/")"; then
    break
  fi
  sleep 0.5
done

case "${response}" in
  *"Hello from Docker Compose corpus!"*) ;;
  *)
    echo "Unexpected response: ${response:-<empty>}" >&2
    docker compose logs web >&2
    exit 1
    ;;
esac

docker compose exec -T redis redis-cli ping | grep -qx "PONG"
