#!/bin/bash -e

ENV=${1:-test}
INSTALL_DIR="${2:-.}"

cd "${INSTALL_DIR}"
LOGFILE=${LOGFILE:-./gitops-${ENV}.log}

function log() {
    echo "$(date -Is) | $*" >>"$LOGFILE"
}

COMPOSE_ARGS=("--ansi" "never")
if [ -f "${ENV}.env" ]; then
    log "Using ${ENV}.env"
    COMPOSE_ARGS+=("--env-file" "${ENV}.env")
fi

COMPOSE_ARGS+=("-f" "docker-compose.yaml")
COMPOSE_ARGS+=("-f" "docker-compose.deploy.yaml")
if [ -f "docker-compose.${ENV}.yaml" ]; then
    log "Found docker-compose.${ENV}.yaml, using it"
    COMPOSE_ARGS+=("-f" "docker-compose.${ENV}.yaml")
fi

ENV_SUFFIX=
if [ "$ENV" != "prod" ]; then
    ENV_SUFFIX="-$ENV"
fi

export ENV ENV_SUFFIX
git fetch --prune
git checkout --force "${MAIN_BRANCH:-main}"
git pull
docker compose "${COMPOSE_ARGS[@]}" up -d --remove-orphans --quiet-pull
docker image prune -f
