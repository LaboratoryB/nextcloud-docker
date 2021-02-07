#!/bin/bash
set -eux pipefail
docker pull docker.io/traefik:2.4
docker pull docker.io/redis:6-alpine
docker pull ghcr.io/linuxserver/nextcloud
docker pull ghcr.io/linuxserver/mariadb
./deploy.sh
