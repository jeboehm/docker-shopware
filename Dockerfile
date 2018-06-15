ARG PHP_VER=7.1

FROM jeboehm/php-nginx-base:${PHP_VER}
LABEL maintainer="jeff@ressourcenkonflikt.de"

ENV \
    MYSQL_HOST=db \
    MYSQL_USER=root \
    MYSQL_PASSWORD=root \
    MYSQL_DATABASE=shopware \
    PATH_IMAGES=/usr/src/test_images.zip \
    PATH_SW=/usr/src/shopware.tar.gz \
    PATH_CONSOLE=/var/www/html/bin/console

RUN apk --no-cache add \
      apache-ant && \
    wget -qO ${PATH_IMAGES} http://releases.s3.shopware.com/test_images.zip

COPY rootfs/ /
VOLUME /var/www/html

CMD [""]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
