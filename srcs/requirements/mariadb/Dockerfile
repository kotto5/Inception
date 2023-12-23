FROM alpine:3.18

RUN apk add mysql mysql-client openrc vim bash \
    && mkdir -p /run/openrc \
    && touch /run/openrc/softlevel \
    && sed -i 's/^skip-networking/skip-networking = 0\nskip-bind-address\nskip-name-resolve\nport = 3306\ncharacter-set-server = utf8/g' /etc/my.cnf.d/mariadb-server.cnf \
    && rc-status \
    && rm -rf /var/lib/mysql \
	&& mkdir -p /var/lib/mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

EXPOSE 3306

COPY ./entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
