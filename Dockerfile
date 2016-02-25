# vim:set ft=dockerfile:

FROM ubuntu:latest
MAINTAINER Pooya Parsa <pooya@pi0.ir>

# Add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r www-data && useradd -r -g www-data www-data

# Install packages
RUN apt-get update
RUN apt-get install git nginx wget \
	php5-fpm php5-curl php5-mysql php5-mcrypt php5-json php5-cli php5-curl php5-dev

# Install composer
RUN wget https://getcomposer.org/composer.phar -o /usr/local/bin/composer && \
	chmod +x /usr/local/bin/composer

# Cleanup
RUN rm -rf /var/lib/apt/lists/*

#Entrypoint Script
ENTRYPOINT ["/entrypoint.sh"]
