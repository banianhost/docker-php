# vim:set ft=dockerfile:

FROM php:7-fpm-alpine
MAINTAINER Pooya Parsa <pooya@pi0.ir>

# Install Base Packages

RUN apk --update --no-cache add \
    supervisor nginx openssl-dev php-cli curl-dev git curl \
    sudo openssh-client icu-dev bzip2-dev

RUN docker-php-ext-install bz2 fileinfo ftp gd gettext gmp iconv \
    intl json mbstring mcrypt mysqli opcache readline posix phar \
    pdo pdo_mysql pdo_sqlite session soap sockets xml xmlreader zip

RUN pecl install mongodb && docker-php-ext-enable mongodb

# Butterfly terminal
RUN apk add --nocache \
    py-pip python-dev libffi-dev && \
    pip install --upgrade pip && \
    pip install butterfly

# Cleanup
RUN rm /var/cache/apk/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 

# Git
RUN mkdir -p /var/www && \
    chown www-data:www-data -R /var/www && \
    sudo -u www-data git config --global credential.helper store

# Nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/nginx-default /etc/nginx/conf.d/default.conf

# Home dir & User
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www && \
    rm -r /home/www-data/ && ln -s /var/www/ /home/www-data && \
    sed -i '/www-data/s/false/sh/g' /etc/passwd

# Lasser
COPY laaser /usr/share/laaser

#Bin
COPY bin /

# Supervisord
COPY  conf/supervisord.conf /etc/supervisord.conf

EXPOSE 80 57575

#Entrypoint Script
WORKDIR /
CMD ["-"]
ENTRYPOINT ["/entrypoint"]
