#!/bin/sh

echo "Waiting for MySQL"

until mysql -h "${MYSQL_HOST}" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SHOW DATABASES;" &> /dev/null
do
	echo -n "."
	sleep 1
done

echo "MySQL ready!"
