# vim:set ft=dockerfile:

FROM ubuntu
MAINTAINER Pooya Parsa <pooya@pi0.ir>

ENV LAAS_VER=2.0
ENV HOME=/var/www
ENV TERM=xterm
ENV SHELL=bash
EXPOSE 80
WORKDIR /

# Install Base Packages
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
    bash supervisor nginx git curl sudo zip unzip xz-utils

# Install node.js
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash \
 && apt-get install -y nodejs

# gulp-cli
RUN npm install --global gulp-cli 
RUN ln /bin/true /bin/notify-send

# Install php
RUN apt-get install -y \
    php php-apcu php-bz2 php-cache php-cli php-curl php-fpm php-gd php-geoip \
    php-gettext php-gmp php-imagick php-imap php-json php-mcrypt php-mbstring php-zip \
    php-memcached php-mongodb php-mysql php-pear php-redis php-xml php-intl php-soap

# Cleanup
RUN rm -rf /var/cache/apt && rm -rf /var/lib/apt

# Install composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin --filename=composer 

# PHP-FPM
RUN mkdir -p /run/php

# Nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/nginx-default /etc/nginx/conf.d/default.conf

# www-data user
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www && \
    ln -s /var/www/ /home/www-data
# Supedvisord
COPY  conf/supervisord.conf /etc/supervisord.conf

#Bin
COPY bin /
RUN ln -s /cmd /bin/ && chmod +x /cmd && chmod +x /bin/cmd

ENTRYPOINT ["/entrypoint"]
