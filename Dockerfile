# vim:set ft=dockerfile:

FROM ubuntu
MAINTAINER Pooya Parsa <pooya@pi0.ir>
ENV LAAS_VER=2.0

# Install Base Packages

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
    bash supervisor nginx git curl sudo openssh-client

# Install node.js and gulp
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
 && apt-get install -y nodejs \
 && npm install --global gulp-cli


# Install php
RUN apt-get install -y \
    php php-apcu php-bz2 php-cache php-cli php-curl php-fpm php-gd php-geoip \
    php-gettext php-gmp php-imagick php-imap php-json php-mcrypt php-mbstring \
    php-memcached php-mongodb php-mysql php-pear php-redis php-xml php-intl php-soap

# Install php v8js
RUN apt-get install -y libv8-dev g++ cpp \
 && pecl install v8js

# Cleanup
RUN rm -rf /var/cache/apt

# Install composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin --filename=composer 

# Nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/nginx-default /etc/nginx/conf.d/default.conf

# www-data user
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www && \
    ln -s /var/www/ /home/www-data

# PHP
RUN mkdir -p /run/php

#Bin
COPY bin /

# Supedvisord
COPY  conf/supervisord.conf /etc/supervisord.conf

# Expose nginx port
EXPOSE 80

#Entrypoint Script
WORKDIR /
ENTRYPOINT ["/entrypoint"]
