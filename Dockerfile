FROM jeboehm/php-nginx-base:latest
MAINTAINER Jeffrey Boehm <jeffrey.boehm@twt.de>

ENV \
    MYSQL_HOST=db \
    MYSQL_USER=root \
    MYSQL_PASSWORD=root \
    MYSQL_DATABASE=shopware

RUN apk --no-cache add \
      mariadb-client \
      apache-ant && \
    wget -O /root/test_images.zip http://releases.s3.shopware.com/test_images.zip

COPY rootfs/ /
ONBUILD VOLUME /var/www/html

CMD [""]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
