[![Docker Pulls](https://img.shields.io/docker/pulls/banian/php.svg)](https://hub.docker.com/r/banian/php)
[![GitHub stars](https://img.shields.io/github/stars/banian/php.svg?style=social&label=Star&?style=flat-square)](https://github.com/banian/php)

# Banian PHP docker image
Painless and production-grade docker image for hosting almost any PHP project!

## Features
- Full **Laravel** Support.
- Production ready and fully dockerized environment for hosting php projects.
- All Data is independent of container, just delete and create an new one any time you want.
- Powered by **Nginx**, **PHP7-FPM** on latest **Ubuntu**.
- PHP **Mongo** extension.
- Node.js 8.x installed.

## Project Structure

You should mount project under `/var/www/src` if you have a `public/` directory (Most of frameworks, including **Laravel**)

Otherwise you can simply mount it under `/var/www/src/public`.

## Running commands as `www` user

You can use sipmy execute `cmd` command to run commands inside project like :

`php exec -it [containerName] cmd php artisan help`

## Vendor Script

You can put your init script to `/bin/vendor` so it will be executed at every update.

## Supervisord

Supervisord includes are supported. if you have any daemon to run with your image just copy config files to `/etc/supervisor/conf.d`

**Example:** Cronjob support

This example will add Cron Jobs Support to Image. 

`/etc/supervisor/conf.d/cron.conf` :
  
```ini
[program:cron]
command = /usr/sbin/cron -f -L 15
stdout_logfile  = /var/log/cron.log
stderr_logfile  = /var/log/cron.log
autorestart=true
```

## Quick Start

Host current directory on port `8080`:

`docker run -it --rm `pwd`:/var/www/src/public -p 8080:80 banian/php`

Using **docker-compose**:

```yaml
version: '3'

services:
  myapp:
    image: banian/php
    volumes:
      - ./www:/var/www
    ports:
      - "8080:80"
    restart: always
```

## License

MIT
