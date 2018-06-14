#!/bin/sh

wait-mysql.sh

install() {
    echo "(1/4) Extracting Shopware..."
    tar --strip 1 -zxf ${PATH_SW}
    ln -sf /usr/bin/composer composer.phar

    echo "(2/4) Installing database and dependencies..."
    ant -f build/build.xml \
        -Ddb.user=${MYSQL_USER} \
        -Ddb.password=${MYSQL_PASSWORD} \
        -Ddb.name=${MYSQL_DATABASE} \
        -Ddb.host=${MYSQL_HOST} \
        build-unit

    echo "(3/4) Extracting the dummy images. This takes some time..."
    unzip -qqn ${PATH_IMAGES}

    echo "(4/4) Migrating the dummy images to their new paths..."
    ${PATH_CONSOLE} -q sw:media:migrate

    echo "Installation completed!"
}

permissions() {
    chown -R www-data:root var/cache/ var/log/ media/ files/ web/cache/
}

if ! [ -r /var/www/html/config.php ]
then
    install
fi

if [ -z $@ ]
then
    echo "Starting Webserver...."
    permissions
    /usr/bin/supervisord -c /etc/supervisord.conf
else
    # TODO extend me!
    case "$@" in
        cc)
            ${PATH_CONSOLE} sw:cache:clear
        ;;
        cron)
            ${PATH_CONSOLE} sw:cron:run
        ;;
        mediamigrate)
            ${PATH_CONSOLE} sw:media:migrate
        ;;
        test)
            composer run test
        ;;
        sh)
            sh
        ;;
        *)
            echo "Commands: cc, mediamigrate, sh"
        ;;
    esac
fi
