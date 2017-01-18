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
    docker-php-ext-install -j$(nproc) \
        bcmath \
        opcache \
        mcrypt \
        pdo_mysql \
        zip && \
    docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \ &&
    docker-php-ext-install -j$(nproc) gd
    rm -rf /var/lib/apt/lists/* && \
    a2enmod rewrite

ENV \
    MYSQL_HOST=db \
    MYSQL_USER=root \
    MYSQL_PASSWORD=root \
    MYSQL_DATABASE=shopware

RUN wget -O /root/test_images.zip http://releases.s3.shopware.com/test_images.zip

COPY rootfs/ /
ONBUILD VOLUME /var/www/html

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
