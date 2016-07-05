# vim:set ft=dockerfile:

FROM ubuntu
MAINTAINER Pooya Parsa <pooya@pi0.ir>

ENV HOME=/var/www
ENV TERM=xterm
ENV SHELL=bash
WORKDIR /
EXPOSE 80

# Install Base Packages
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
    bash supervisor nginx git curl sudo zip unzip xz-utils

# Install php
RUN apt-get install -y \
    php php-apcu php-bz2 php-cache php-cli php-curl php-fpm php-gd php-geoip \
    php-gettext php-gmp php-imagick php-imap php-json php-mcrypt php-mbstring php-zip \
    php-memcached php-mongodb php-mysql php-pear php-redis php-xml php-intl php-soap \
    php-sqlite3 php-dompdf php-fpdf php-guzzlehttp php-guzzlehttp-psr7 php-jwt  php-ssh2 \

# Install node.js
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash \
 && apt-get install -y nodejs

# gulp-cli
RUN npm install --global gulp-cli 

# Cleanup
RUN rm -rf /var/cache/apt && rm -rf /var/lib/apt

# Install composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin --filename=composer

# Permissions
RUN chown www-data:www-data -R /root

# PHP-FPM
RUN mkdir -p /run/php
COPY conf/www.conf /etc/php/7.0/fpm/pool.d/www.conf

# Nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/nginx-default /etc/nginx/conf.d/default.conf

# www-data user
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www && \
    ln -s /var/www/ /home/www-data

# Supedvisord
COPY conf/supervisord.conf /etc/supervisord.conf

# Bin
COPY bin /bin

ENTRYPOINT ["entrypoint"]
