#!/bin/bash
# shell.env: get into a shell inside the Nextcloud container
source .env
set -euxo pipefail
APP_SERVICE=nextcloud_app
APP_CONTAINER=$(docker ps -f name=${APP_SERVICE} --quiet --no-trunc)
SHELL_CMD=/bin/bash
docker exec \
         -it \
         -u ${NEXTCLOUD_UID}:${NEXTCLOUD_GID} \
         -e "HOME=/config/www/nextcloud" \
         ${APP_CONTAINER} \
         /bin/bash \
         -c "echo \"alias occ='/usr/bin/php /config/www/nextcloud/occ'\" > /config/www/nextcloud/.bashrc; bash"
