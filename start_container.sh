#!/bin/bash
# Usage: ./start_container.sh [drone_id] [box_id] [img_version]
# Examples:
#   ./start_container.sh                    # Uses d1, b1, latest
#   ./start_container.sh d10 b10            # Uses d10, b10, latest
#   ./start_container.sh d10 b10 v1.0.0     # Uses d10, b10, v1.0.0

DRONE_ID="${1:-d1}"
BOX_ID="${2:-b1}"
IMG_VERSION="${3:-latest}"

COMPOSE_PROJECT_NAME="phx-sim-${DRONE_ID}-${BOX_ID}"

IMG_VERSION="${IMG_VERSION}" \
DRONE_ID="${DRONE_ID}" \
BOX_ID="${BOX_ID}" \
COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME}" \
docker compose up