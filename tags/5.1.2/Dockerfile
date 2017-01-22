FROM jeboehm/shopware:base
MAINTAINER Jeffrey Boehm <jeffrey.boehm@twt.de>

ENV SHOPWARE_VERSION=5.1.2 \
    COMPOSER_VERSION=1.1.2

RUN wget -qO /root/shopware.tar.gz https://github.com/shopware/shopware/archive/v$SHOPWARE_VERSION.tar.gz && \
    wget -qO /usr/local/bin/composer https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar && \
    chmod 755 /usr/local/bin/composer
