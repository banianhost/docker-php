# Banian PHP docker image

[![Docker Pulls](https://img.shields.io/docker/pulls/banian/php.svg)](https://hub.docker.com/r/banian/php)
[![GitHub stars](https://img.shields.io/github/stars/banian/php.svg?style=social&label=Star&?style=flat-square)](https://github.com/banian/php)

Painless and production-grade docker image for hosting almost any PHP project.

## Features

- **Laravel** Support
- Production ready and stable for any PHP project
- Powered by **Nginx**, **PHP7-FPM** on latest **Ubuntu**
- PHP extensions already installed, including MongoDB driver
- Allows passing envrionment variables to PHP scripts
- Node, Yarn and Composer installed

## Quick Start

Host current directory on port `8080`:

```bash
docker run -it --rm `pwd`:/var/www/src/public -p 8080:80 banian/php
```

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


## Project Structure

You should mount project under `/var/www/src` if you have a `public/` directory (Most of frameworks, including **Laravel**)

Otherwise you can simply mount it under `/var/www/src/public`.

## Scripts

### `fixperms`

This script sets correct ownership for www and log files. For faster startup, fixing `/var/www/src` will be done in background.

### logs`

Tails all PHP and Nginx logs.

### `run-as-www`

Useful for running commands as `www-data` inside project.

**Example:** `docker exec -it [containerName] run-as-www php artisan help`

### `update`

- Run `composer install` and `yarn install` if derectedd. A lock file `/var/www/update.lock` will be created to prevent running more than once.

## Supervisord

If you have any daemon to run with your project just copy add config files into `/etc/supervisor/conf.d`

**Example:** Cronjob support

`/etc/supervisor/conf.d/cron.conf` :
  
```ini
[program:cron]
command = /usr/sbin/cron -f -L 15
stdout_logfile = /var/log/cron.log
stderr_logfile = /var/log/cron.log
autorestart = true
```

## License

MIT
