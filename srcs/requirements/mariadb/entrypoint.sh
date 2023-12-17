#!/bin/sh -x

# read .env file
# .env 内で参照し、かつcontainer に環境変数を共有したくない場合がある (root password等 全部そうしてもいいかも)
if [[ -f .env ]]; then
    export $(grep -v '^#' .env | xargs)
fi

# if $DATADIR/mysql not exist, initialize database
if [ ! -d "${MYSQL_DATA_PATH}/mysql" ]; then
	rc-service mariadb setup
    rc-service mariadb start

	echo "CREATE USER '${DB_USER}' IDENTIFIED BY '${DB_PASS}';" >> sql_text
    echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME} DEFAULT CHARACTER SET utf8;"  >> sql_text
    echo "grant all privileges on ${DB_NAME}.* to ${DB_USER}@'%' identified by '${DB_PASS}' with grant option ;" >> sql_text
    echo "DELETE FROM mysql.user WHERE User='';" >> sql_text
    # echo "DROP USER ''@'localhost';" >> sql_text
    echo "DROP DATABASE test;" >> sql_text
    # password to root
    echo "${MYSQL_ROOT_PASSWORD}"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY ${MYSQL_ROOT_PASSWORD};" >> sql_text
    echo "FLUSH PRIVILEGES;" >> sql_text
    cat sql_text | mysql -u root
    # after this command, root password need to access as root user;
    rm sql_text
    rc-service mariadb stop
fi

exec mysqld --datadir=/var/lib/mysql --user=mysql
