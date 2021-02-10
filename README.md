# Nextcloud Docker Stack

Securely run your own Nextcloud instance using Docker Swarm.

![Nextcloud Logo](/img/logo_nextcloud_blue.png)

## Prerequisites
- Linux (kernel 4.0+)
- Docker (API version 1.24+)
- GNU Bash
- OpenSSL (for generating passwords)
- At least 2GB of free disk space


## Quick Start
These instructions are for setting up a single-node Nextcloud instance at https://nextcloud.example.com. Substitute nextcloud.example.com for your desired subdomain.

1. Find your public IPv4 address by going to https://ipv4.icanhazip.com. Add an A record in your domain's DNS for your desired subdomain. For example, create an A record for `nextcloud` with the value `208.69.38.205` fin the DNS records for zone `example.com`.

2. Clone this repo:
```bash
git clone https://github.com/LaboratoryB/nextcloud-docker.git
```

3. Start a Docker Swarm. If you have an existing Swarm, skip this step and join it instead.
```bash
docker swarm init
```

4. Run `generate-env.sh` to create your environment configuration, and generate database passwords:
```bash
cd nextcloud-docker
./generate-env.sh nextcloud.example.com
```

5. Set up a DHCP reservation in your router, or a static LAN IP, so you get the same local IP every time.

6. [Forward ports](https://portforward.com/router.htm) 80 and 443 through your router, to the machine running Docker.

7. Wait 60 seconds and check for your change with a public DNS checker like https://whatsmydns.net or https://dnschecker.org. Confirm your change has propagated to at least most, if not all zones before proceeding.

8. Run `deploy.sh` to apply your configuration and start up the Docker Swarm stack:
```bash
./deploy.sh
```

9. Find the local IP of the machine running Docker, for example `10.0.0.10`, `192.168.1.10`, or if you are running Docker on the machine you're reading this on, `127.0.0.1`. Add this along with your Nextcloud subdomain to your hosts file by running:
```bash
echo "127.0.0.1 nextcloud.example.com" | sudo tee -a /etc/hosts
```

10. Visit your Nextcloud instance in the browser, for example at https://nextcloud.example.com. You may get an insecure site warning, this is OK for now, within a few minutes if your port forward and DNS setup is correct, it will switch to a secure connection.

11. Complete the installation form, with the following information:
- An admin username of your choosing
- An admin password of your choosing
- Storage: `/data`
- Database: `MySQL`
- Database user: `nextcloud-installer`
- Database password: look for MYSQL_USER_PASSWORD in .env
- Database name: `nextcloud`
- Database host: `nextcloud_mariadb`

12. Just after the first 2 lines, add the following to `nextcloud/config/www/nextcloud/config/config.php` :
```
  'memcache.distributed' => '\\OC\\Memcache\\Redis',
  'memcache.locking' => '\\OC\\Memcache\Redis',
  'redis' => array (
    'host' => 'nextcloud_redis',
    'port' => 6379
  ),
  'trusted_proxies' => array (
    0 => '10.0.0.0/16',
  ),
```
13. Try logging in to your Nextcloud instance in the browser again to confirm these changes didn't break it.

14. See if you can reach your Nextcloud instance from the public Internet, using mobile data, or a site like https://downforeveryoneorjustme.com

15. Run the [Nextcloud Security Scan](https://scan.nextcloud.com/), which will confirm Nextcloud is up to date, and all their major recommended security measures are in place.

16. Check your server with [Qualys SSL Labs](https://www.ssllabs.com/) to confirm your HTTPS implementation is secure.

## Updating
An updater script is included, that will get the latest container images for Traefik, Nextcloud, MariaDB, Redis, and immediately update to them. Running this script will cause your Nextcloud instance to be temporarily go offline, usually only about a minute.

To update, open a terminal and run:
```bash
./update.sh
```

## License

Copyright © 2021 Aaron Silber

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).

Please note, each individual application this stack lets you run is governed by their own respective license. For example, Nextcloud is licensed under AGPLv3 at the time of writing. Be sure to adhere to these licenses as well if you make use of this project.

## Trademarks

Nextcloud and the Nextcloud Logo is a registered trademark of Nextcloud GmbH. in Germany and/or other countries. The presence of the Nextcloud trademark does not imply this project or its authors are endorsed by, or endorse Nextcloud GmbH.

The Nextcloud trademarks present here are used in accordance with the [Nextcloud Trademark Guidelines](https://nextcloud.com/trademarks/) as this project constitutes unmodified distribution of Nextcloud.
