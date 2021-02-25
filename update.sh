#!/bin/bash
# update.sh - download updates to all containers, and immediately apply them
set -euxo pipefail
# pull down the latest container images
docker pull docker.io/traefik:2.4
docker pull docker.io/redis:6-alpine
docker pull ghcr.io/linuxserver/nextcloud
docker pull docker.io/mariadb:10
# redeploy the Swarm service to use the new images
./deploy.sh
