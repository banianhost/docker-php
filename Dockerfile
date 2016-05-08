# vim:set ft=dockerfile:

FROM php:fpm
MAINTAINER Pooya Parsa <pooya@pi0.ir>

ENV V=1.9

# Install Base Packages

RUN apt-get update && apt-get install -y \
    bash supervisor nginx git curl \
    sudo openssh-client libxml2-dev libpng-dev \
    libbz2-dev libicu-dev libcurl4-openssl-dev libgmp3-dev \
    libmcrypt-dev libedit-dev libssl-dev

RUN docker-php-ext-install bz2 ftp gd gettext \
    intl mcrypt mysqli opcache pdo_mysql soap zip \
    > /dev/null

RUN pecl install mongodb && docker-php-ext-enable mongodb

# Cleanup

# Install composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin --filename=composer 

# Git
RUN mkdir -p /var/www && \
    chown www-data:www-data -R /var/www && \
    sudo -u www-data git config --global credential.helper store

# Nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/nginx-default /etc/nginx/conf.d/default.conf

# Home dir & User
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www && \
    ln -s /var/www/ /home/www-data && \
    sed -i '/www-data/s/false/bash/g' /etc/passwd

#Bin
COPY bin /

# Supervisord
COPY  conf/supervisord.conf /etc/supervisord.conf

# Expose nginx and butterfly ports
EXPOSE 80 57575

#Entrypoint Script
WORKDIR /
CMD ["-"]
ENTRYPOINT ["/entrypoint"]
