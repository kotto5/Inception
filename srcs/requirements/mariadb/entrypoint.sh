#!/bin/sh -x

# if $DATADIR/mysql not exist, initialize database
if [ ! -d "${MYSQL_DATA_PATH}/mysql" ]; then
	rc-service mariadb setup
    rc-service mariadb start

	echo "CREATE USER '${DB_USER}' IDENTIFIED BY '${DB_PASS}';" >> sql_text
    echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME} DEFAULT CHARACTER SET utf8;"  >> sql_text
    echo "grant all privileges on ${DB_NAME}.* to ${DB_USER}@'%' identified by '${DB_PASS}' with grant option ;" >> sql_text
    cat sql_text | mysql -u root
    # after this command, root password need to access as root user;
    rm sql_text
    rc-service mariadb stop
fi

exec mysqld --datadir=/var/lib/mysql --user=mysql
