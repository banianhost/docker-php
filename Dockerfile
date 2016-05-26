# vim:set ft=dockerfile:

FROM ubuntu
MAINTAINER Pooya Parsa <pooya@pi0.ir>
ENV LAAS_VER=2.0

# Install Base Packages

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
    bash supervisor nginx git curl sudo openssh-client \
    software-properties-common build-essential make gcc

# Install node.js
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash \
 && apt-get install -y nodejs

# Install php
RUN apt-get install -y \
    php php-apcu php-bz2 php-cache php-cli php-curl php-fpm php-gd php-geoip \
    php-gettext php-gmp php-imagick php-imap php-json php-mcrypt php-mbstring \
    php-memcached php-mongodb php-mysql php-pear php-redis php-xml php-intl php-soap php-dev

# Install additional packages
RUN apt-get install -y \
   zip unzip php-zip

# Cleanup
RUN rm -rf /var/cache/apt

# Install composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin --filename=composer 

# V8-JS
RUN curl -#L https://ni8.ir/v8js.txz | tar -xJvf-
RUN mv release/*.so /usr/lib && rm -r release \
 && echo "extension=/usr/lib/v8js.so" > /etc/php/7.0/mods-available/v8js.ini \
 && phpenmod v8js

# Gulp
RUN npm install --global gulp-cli

# PHP-FPM
RUN mkdir -p /run/php

# Nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/nginx-default /etc/nginx/conf.d/default.conf

# www-data user
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www && \
    ln -s /var/www/ /home/www-data

#Bin
COPY bin /
RUN ln -s /cmd /bin/ && chmod +x /cmd && chmod +x /bin/cmd

# Supedvisord
COPY  conf/supervisord.conf /etc/supervisord.conf

# Default repo
ENV GIT_REPO=.

# Expose nginx port
EXPOSE 80

#Entrypoint Script
WORKDIR /
ENTRYPOINT ["/entrypoint"]
