#!/bin/bash -e

DIR="${1:-.}"

mkdir -p "${DIR}/logs"
find "$DIR" -maxdepth 1 -type f -name "*.log" | while read -r f; do
    mv "$f" "${DIR}/logs/$(basename .log)_$(date -Idate).log"
done
find "${DIR}/logs" -type f -name "*.log" -mtime +7 -delete
