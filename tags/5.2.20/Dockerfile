FROM jeboehm/shopware:base
MAINTAINER Jeffrey Boehm <jeffrey.boehm@twt.de>

ENV SHOPWARE_VERSION=5.2.20 \
    COMPOSER_VERSION=1.4.1

RUN wget -qO /root/shopware.tar.gz https://github.com/shopware/shopware/archive/v$SHOPWARE_VERSION.tar.gz && \
    wget -qO /usr/local/bin/composer https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar && \
    chmod 755 /usr/local/bin/composer
