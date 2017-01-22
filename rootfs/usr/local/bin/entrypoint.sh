#!/bin/sh

wait-mysql.sh

if ! [ -r /var/www/html/config.php ]
then
	echo "Installing Shopware..."

	tar --strip 1 -zxf /root/shopware.tar.gz
	ln -sf /usr/local/bin/composer composer.phar

	ant -f build/build.xml \
		-Ddb.user=${MYSQL_USER} \
		-Ddb.password=${MYSQL_PASSWORD} \
		-Ddb.name=${MYSQL_DATABASE} \
		-Ddb.host=${MYSQL_HOST} \
		build-unit

	unzip -n /root/test_images.zip
fi

if [ -z $@ ]
then
	echo "Starting Webserver.."
	chmod -R 777 var/cache/ var/log/
	/usr/bin/supervisord -c /etc/supervisord.conf
else
	# TODO extend me!
	case "$@" in
		cc)
			var/cache/clear_cache.sh
			;;
		sh)
			sh
			;;
		*)
			echo "Commands: cc, sh"
			;;
	esac
fi
