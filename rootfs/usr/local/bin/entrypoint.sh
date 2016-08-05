#!/bin/sh

wait-mysql.sh

if ! [ -r /var/www/html/config.php ]
then
	echo "Installing Shopware..."

	tar --strip 1 -zxf /root/shopware.tar.gz
	ln -s /usr/local/bin/composer composer.phar

	ant -f build/build.xml \
		-Ddb.user=${MYSQL_USER} \
		-Ddb.password=${MYSQL_PASSWORD} \
		-Ddb.name=${MYSQL_DATABASE} \
		-Ddb.host=${MYSQL_HOST} \
		build-unit
fi

if [ -z $@ ]
then
	echo "Starting Webserver.."
	chmod -R 777 var/cache/ var/log/
	apache2-foreground
else
	# TODO extend me!
	case "$@" in
		cc)
			var/cache/clear_cache.sh
			;;
		sh)
			bash
			;;
		*)
			echo "Commands: cc, sh"
			;;
	esac
fi
