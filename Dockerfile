FROM php:7.0-apache
MAINTAINER Jeffrey Boehm <jeffrey.boehm@twt.de>

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        ant \
        git \
        unzip \
        mysql-client \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev && \
    docker-php-ext-install -j5 \
        opcache \
        gd \
        mcrypt \
        pdo_mysql \
        zip && \
    rm -rf /var/lib/apt/lists/* && \
    a2enmod rewrite

ENV \
    MYSQL_HOST=db \
    MYSQL_USER=root \
    MYSQL_PASSWORD=root \
    MYSQL_DATABASE=shopware

COPY rootfs/ /
ONBUILD VOLUME /var/www/html

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
