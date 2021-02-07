#!/bin/bash
# update.sh - download updates to all containers, and immediately apply them
set -eux pipefail
# pull down the latest container images
docker pull docker.io/traefik:2.4
docker pull docker.io/redis:6-alpine
docker pull ghcr.io/linuxserver/nextcloud
docker pull ghcr.io/linuxserver/mariadb
# redeploy the Swarm service to use the new images
./deploy.sh
