#!/bin/sh

wait-mysql.sh

if ! [ -r /var/www/html/config.php ]
then
	echo "Installing Shopware..."

	tar --strip 1 -zxf ${PATH_SW}
	ln -sf /usr/bin/composer composer.phar

	ant -f build/build.xml \
		-Ddb.user=${MYSQL_USER} \
		-Ddb.password=${MYSQL_PASSWORD} \
		-Ddb.name=${MYSQL_DATABASE} \
		-Ddb.host=${MYSQL_HOST} \
		build-unit

	unzip -n ${PATH_IMAGES}
fi

if [ -z $@ ]
then
	echo "Starting Webserver.."
	chown -R www-data:root var/cache/ var/log/ media/ files/ web/cache/
	/usr/bin/supervisord -c /etc/supervisord.conf
else
	# TODO extend me!
	case "$@" in
		cc)
			/var/www/html/var/cache/clear_cache.sh
			;;
		cron)
		  /var/www/html/bin/console sw:cron:run
			;;
		mediamigrate)
		  /var/www/html/bin/console sw:media:migrate
			;;
		sh)
			sh
			;;
		*)
			echo "Commands: cc, sh"
			;;
	esac
fi
