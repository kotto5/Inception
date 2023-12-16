# vim:set ft=dockerfile:
FROM alpine:3.19

RUN apk add mysql mysql-client openrc vim bash \
    && mkdir -p /run/openrc \
    && touch /run/openrc/softlevel \
    && mkdir /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql \
    && mysql_install_db --user=mysql --datadir=/var/lib/mysql \
    && rc-service mariadb setup
    # && rc-service mariadb start
    # && addgroup -S mysql && adduser -S -G mysql kakiba

# VOLUME /var/lib/mysql

# COPY ./healthcheck.sh /usr/local/bin/healthcheck.sh
# COPY ./docker-entrypoint.sh /usr/local/bin/
# ENTRYPOINT ["docker-entrypoint.sh"]

# EXPOSE 3306
# CMD ["mariadbd"]
CMD ["sleep", "infinity"]
