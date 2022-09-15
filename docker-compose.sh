#!/bin/bash -e

DC_ENV=${DC_ENV:-test}

COMPOSE_ARGS=()
if [ -f "${DC_ENV}.env" ]; then
    COMPOSE_ARGS+=("--env-file" "${DC_ENV}.env")
fi

if [ -f "docker-compose.yaml" ]; then
  COMPOSE_ARGS+=("-f" "docker-compose.yaml")
fi
if [ -f "docker-compose.deploy.yaml" ]; then
  COMPOSE_ARGS+=("-f" "docker-compose.deploy.yaml")
fi
if [ -f "docker-compose.${DC_ENV}.yaml" ]; then
    COMPOSE_ARGS+=("-f" "docker-compose.${DC_ENV}.yaml")
fi

ENV_SUFFIX=
if [ "$DC_ENV" != "prod" ]; then
    ENV_SUFFIX="-$DC_ENV"
fi

ENV=${DC_ENV} ENV_SUFFIX=${ENV_SUFFIX} \
  exec docker compose "${COMPOSE_ARGS[@]}" "${@}"
