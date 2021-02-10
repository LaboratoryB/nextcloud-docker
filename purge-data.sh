#!/bin/bash
# remove.sh - remove **ALL DATA** to start fresh
rm .env
rm -rf mariadb/config/*
rm nextcloud/config/.rnd
rm -rf nextcloud/data/*
rm -rf nextcloud/config/keys
rm -rf nextcloud/config/crontabs
rm -rf nextcloud/config/log
rm -rf nextcloud/config/php
rm -rf nextcloud/config/www
rm nextcloud/config/nginx/nginx.conf
