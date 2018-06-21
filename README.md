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
- Node.js 8.x 

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

`entrypoint`

- This is the default entrypoint that will be called on start. If any argument is passed it will simply run that command and exits, otherwise `fixperm`, `entrypoint-www` and `supervisord` will be called respectively.

`entrypoint-www`

- This script should be only called by `entrypoint`. It ensures `public` directory exists and cleans up `update.lock` file.

`fixperm`

- This script sets currect ownership for src and log files. For faster startup, fixing `src` will be done in background.

`logs`

- Tails all logs

`run-as-www`

- Useful for running commands as `www-data` user inside project: `docker exec -it [containerName] run-as-www php artisan help`

`update`

- Run `composer install` and `/bin/update` if exists. A lock file `update.lock` prevents this script to be running more than once at a time.

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
