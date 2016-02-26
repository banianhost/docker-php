[![Docker Repository on Quay](https://quay.io/repository/pooya/laas/status "Docker Repository on Quay")](https://quay.io/repository/pooya/laas)

# Laas ( Laravel As A Service )
Painless and Automated Laravel Docker instances Hosting and Deployment.

## What is Laravel
Laravel is a free, open-source PHP web framework, created by Taylor Otwell and intended for the development of web applications following the model–view–controller (MVC) architectural pattern. [Laravel](https://laravel.com)

## What is Docker
Docker allows you to package an application with all of its dependencies into a standardized unit for software development. [Docker](https://www.docker.com)

# What is Laas
Laas is developed under inspiration of [Laravel Forge](https://forge.laravel.com) Project, which allows you deploy and host your laravel projects wihout any configuraion. Laas is Free, Self Hosted and More powerful.

## Laaser Webui
Every container has a WebUI Injected to,called laaser.which allows you easily manage laravel project without directly accessing artisan.

# Features
- Production ready And fully dockerized environment for hosting Laravel applications
- All Data is independent of container, just delete and create an new one any time you want
- Powered by **Nginx**, **PHP-FPM** on **Debian** Jessie
- **Webhooks** are ready ! Just push and commit your changes and your site is up!
- PHP **Mongo** extension compiled
- **SSH-Keys** are auto-generated for git access
- Very **Light**, no database running inside container
- Easy Container Managment Through **Laaser Webui**
 

# Quick Start
Im Working on an Easier and Automated Soloution.

To run a test Instance
```bash
docker run --rm -p 2739:80 -itv /tmp/lass_test:/var/www pooya/laas http://github.com/bestmomo/laravel5-exampe
```
Your container is Ready on `http://host_ip:2739`
    
To run a instance that starts at host boot time:
```bash
docker run --name <Name> --restart=always -itdv <DataStorage>:/var/www pooya/laas <YourLaravelProjectGitURL>
```

