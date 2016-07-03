[![Docker Repository on Quay](https://quay.io/repository/pooya/paas/status "Docker Repository on Quay")](https://quay.io/repository/pooya/paas)
[![](https://badge.imagelayers.io/pooya/paas:latest.svg)](https://imagelayers.io/?images=pooya/paas:latest 'Get your own badge on imagelayers.io')


# Paas (PHP as a service )
Painless and automated any PHP Project docker instances hosting and deployment.   
paas is developed under inspiration of [Laravel Forge](https://forge.laravel.com) Project, which allows you deploy and host your laravel projects wihout any configuraion. paas is Free, Self Hosted and More powerful. ** And can be used for ANY php framework or project **.
  
# Features
- Full **Laravel** Support.
- Production ready And fully dockerized environment for hosting php projects.
- All Data is independent of container, just delete and create an new one any time you want.
- Powered by **Nginx**, **PHP7-FPM** on latest **Ubuntu**.
- **Webhooks** are ready ! Just push and commit your changes and your site is up!
- PHP **Mongo** extension.
- **SSH-Keys** are auto-generated for git access.
- **Node js 7.0** & **Gulp** installed, just exec `gulp` from container

# Webhook

Simply set `WEBHOOK_SECRET` environemnt and use injected url `http://project_url/webhook.php?secret=123` to use webhook.   
if you want to add custom commands, create a `.webhookrc` script in root of your repository.  

# Project Structure

As we follow laravel standards, your project should have a directory named ```public```, if it does not exists, init script **will automaticly create a syslink from source to public**.

# Running commands

You can use sipmy execute commands to run commands inside project like :
``` php exec -it <container_name> php artisan help ```

# Quick Start

## Simple docker-compose.yml

```yaml
version: '2'
services:
  laravel:
    image: pooya/paas
    volumes:
      - ./data/www:/var/www
    environment:
      -  VIRTUAL_HOST=my.subdomain.tld,butterfly.my.subdomain.dld
      -  GIT_REPO=https://github.com/some/repo.git
      -  PASSWORD=www-data_password
      -  WEBHOOK_SECRET=123
    restart: always
    network_mode: "bridge"
```

## Alternative docker-compose.yml:  
You can also create a docker compose file inside your repository and mount project to `/var/www/src`
   
docker-compose.yaml: (inside your repo)
```yaml
version: '2'
services:
  www:
    image: pooya/paas
    volumes:
      - .:/var/www/src
    env_file: .env
    network_mode: "bridge"
    restart: always
```
   
# Git Ignores
To prevent confilctes, ignore generated files:
  
.gitingnore:
```
.paas.lock
public/webhook.php
```
