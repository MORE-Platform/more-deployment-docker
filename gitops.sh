#!/bin/bash -e

ME="$(readlink -f "$0")"
BASE_DIR="$(dirname "$ME")"

ENV=${1:-test}
INSTALL_DIR="${2:-.}"

cd "${INSTALL_DIR}"
LOGFILE=${LOGFILE:-./gitops-${ENV}.log}

{
git fetch --prune
git checkout --force "${MAIN_BRANCH:-main}"
git pull
DC_ENV="${ENV}" "${BASE_DIR}/docker-compose.sh" --ansi never up -d --remove-orphans --quiet-pull
docker image prune -f
} &>"$LOGFILE"
