#!/bin/bash

# Simple wrapper to run podman-compose with a specific compose file
# Supports commands: start, stop, restart, up, down, logs

set -euo pipefail

COMPOSE_FILE="/opt/bloodhound/server/docker-compose.yaml"

# Function to display usage
usage() {
  echo "Usage: $0 [start|stop|restart|up|down|ps|logs] [/path/to/docker-compose.yml]"
  exit 1
}

# Check if at least one arguments are given
if [[ $# -lt 1 ]]; then
  usage
fi

COMMAND="$1"
shift 

case "$COMMAND" in
  up)
    podman-compose -f "$COMPOSE_FILE" up -d "$@"
    ;;
  down|start|stop|ps|restart|logs)
    podman-compose -f "$COMPOSE_FILE" "$COMMAND" "$@"
    ;;
  *)
    echo "Unsupported command: $COMMAND"
    usage
    ;;
esac
