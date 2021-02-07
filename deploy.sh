#!/bin/bash
set -x pipefail
if [ ! -f ./.env ]; then
  echo '.env does not exist. Generating environnent variables...'
  ./generate-env.sh
fi
echo 'Loading environment variables from .env...'
source .env
echo 'Generating a stack.yml from template...'
envsubst < ./stack-templates/stack.yml > stack.yml
docker stack deploy -c stack.yml nextcloud
