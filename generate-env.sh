#!/bin/bash
NEXTCLOUD_HOST_DOMAIN=$1
if [ -z "$1" ]; then
  echo "Error: please pass your desired domain name."
  echo "Example: ./generate-env.sh cloud.laboratoryb.org"
  exit 1
fi
set -euxo pipefail
ENV_FILE=./.env
if [ -f "$ENV_FILE" ]; then
  echo "Warning: Existing environment variables already exist at $ENV_FILE"
  echo "If you proceed, this script will overwrite existing environment variables."
  echo "You may lose any generated passwords contained in this file."
  echo "This may break your existing Nextcloud instance if one exists."
  echo "You should only proceed if you know what you are doing."
  read -r -p "Are you sure? [y/N] " response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Continuing and will overwrite environment variable file."
  else
    echo "Exiting."
    exit 1;
  fi
fi
TIMEZONE=America/New_York
MYSQL_ROOT_PASSWORD=$(openssl rand -base64 32)
MYSQL_USER_PASSWORD=$(openssl rand -base64 32)
DEFAULT_UID=$(id -u);
DEFAULT_GID=$(id -g);
echo '#!/bin/bash' > $ENV_FILE
echo "export TIMEZONE=$TIMEZONE" >> $ENV_FILE
echo "export MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" >> $ENV_FILE
echo "export MYSQL_USER_PASSWORD=$MYSQL_USER_PASSWORD" >> $ENV_FILE
echo "export NEXTCLOUD_HOST_DOMAIN=$NEXTCLOUD_HOST_DOMAIN" >> $ENV_FILE
echo "export NEXTCLOUD_UID=$DEFAULT_UID" >> $ENV_FILE
echo "export NEXTCLOUD_GID=$DEFAULT_GID" >> $ENV_FILE
