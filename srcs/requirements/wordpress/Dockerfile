FROM alpine:3.17.2

RUN apk add --update --no-cache php81 php81-fpm php81-mysqli php81-phar php81-iconv mariadb-client

# Install wget
ENV WP_PATH=/var/www/html/wordpress
# Download, Extract, Move to /var/www/html, and Remove wordpress.tar.gz in one line
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp \
	&& adduser -u 82 -D -S -G www-data www-data \
	&& mkdir -p $WP_PATH \
	&& wp core download --path=$WP_PATH --allow-root \
	&& chown -R www-data:www-data /var/www/html/wordpress

#COPY conf/wp-config.php /var/www/html/wordpress/wp-config.php
COPY conf/zz-docker.conf /etc/php81/php-fpm.d/zz-docker.conf

EXPOSE 9000

# php-fpm can't run as www-data, why?
#USER www-data
WORKDIR /var/www/html/wordpress
COPY ./entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
#ENTRYPOINT ["php-fpm81", "--nodaemonize"]

# #
# # NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
# #
# # PLEASE DO NOT EDIT IT DIRECTLY.
# #

# FROM php:8.1-fpm-alpine

# # persistent dependencies
# RUN set -eux; \
# 	apk add --no-cache \
# # in theory, docker-entrypoint.sh is POSIX-compliant, but priority is a working, consistent image
# 		bash \
# # Ghostscript is required for rendering PDF previews
# 		ghostscript \
# # Alpine package for "imagemagick" contains ~120 .so files, see: https://github.com/docker-library/wordpress/pull/497
# 		imagemagick \
# 	;

# # install the PHP extensions we need (https://make.wordpress.org/hosting/handbook/handbook/server-environment/#php-extensions)
# RUN set -ex; \
# 	\
# 	apk add --no-cache --virtual .build-deps \
# 		$PHPIZE_DEPS \
# 		freetype-dev \
# 		icu-dev \
# 		imagemagick-dev \
# 		libjpeg-turbo-dev \
# 		libpng-dev \
# 		libwebp-dev \
# 		libzip-dev \
# 	; \
# 	\
# 	docker-php-ext-configure gd \
# 		--with-freetype \
# 		--with-jpeg \
# 		--with-webp \
# 	; \
# 	docker-php-ext-install -j "$(nproc)" \
# 		bcmath \
# 		exif \
# 		gd \
# 		intl \
# 		mysqli \
# 		zip \
# 	; \
# # WARNING: imagick is likely not supported on Alpine: https://github.com/Imagick/imagick/issues/328
# # https://pecl.php.net/package/imagick
# 	pecl install imagick-3.6.0; \
# 	docker-php-ext-enable imagick; \
# 	rm -r /tmp/pear; \
# 	\
# # some misbehaving extensions end up outputting to stdout 🙈 (https://github.com/docker-library/wordpress/issues/669#issuecomment-993945967)
# 	out="$(php -r 'exit(0);')"; \
# 	[ -z "$out" ]; \
# 	err="$(php -r 'exit(0);' 3>&1 1>&2 2>&3)"; \
# 	[ -z "$err" ]; \
# 	\
# 	extDir="$(php -r 'echo ini_get("extension_dir");')"; \
# 	[ -d "$extDir" ]; \
# 	runDeps="$( \
# 		scanelf --needed --nobanner --format '%n#p' --recursive "$extDir" \
# 			| tr ',' '\n' \
# 			| sort -u \
# 			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
# 	)"; \
# 	apk add --no-network --virtual .wordpress-phpexts-rundeps $runDeps; \
# 	apk del --no-network .build-deps; \
# 	\
# 	! { ldd "$extDir"/*.so | grep 'not found'; }; \
# # check for output like "PHP Warning:  PHP Startup: Unable to load dynamic library 'foo' (tried: ...)
# 	err="$(php --version 3>&1 1>&2 2>&3)"; \
# 	[ -z "$err" ]

# # set recommended PHP.ini settings
# # see https://secure.php.net/manual/en/opcache.installation.php
# RUN set -eux; \
# 	docker-php-ext-enable opcache; \
# 	{ \
# 		echo 'opcache.memory_consumption=128'; \
# 		echo 'opcache.interned_strings_buffer=8'; \
# 		echo 'opcache.max_accelerated_files=4000'; \
# 		echo 'opcache.revalidate_freq=2'; \
# 	} > /usr/local/etc/php/conf.d/opcache-recommended.ini
# # https://wordpress.org/support/article/editing-wp-config-php/#configure-error-logging
# RUN { \
# # https://www.php.net/manual/en/errorfunc.constants.php
# # https://github.com/docker-library/wordpress/issues/420#issuecomment-517839670
# 		echo 'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR'; \
# 		echo 'display_errors = Off'; \
# 		echo 'display_startup_errors = Off'; \
# 		echo 'log_errors = On'; \
# 		echo 'error_log = /dev/stderr'; \
# 		echo 'log_errors_max_len = 1024'; \
# 		echo 'ignore_repeated_errors = On'; \
# 		echo 'ignore_repeated_source = Off'; \
# 		echo 'html_errors = Off'; \
# 	} > /usr/local/etc/php/conf.d/error-logging.ini

# RUN set -eux; \
# 	version='6.4.2'; \
# 	sha1='d1aedbfea77b243b09e0ab05b100b782497406dd'; \
# 	\
# 	curl -o wordpress.tar.gz -fL "https://wordpress.org/wordpress-$version.tar.gz"; \
# 	echo "$sha1 *wordpress.tar.gz" | sha1sum -c -; \
# 	\
# # upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
# 	tar -xzf wordpress.tar.gz -C /usr/src/; \
# 	rm wordpress.tar.gz; \
# 	\
# # https://wordpress.org/support/article/htaccess/
# 	[ ! -e /usr/src/wordpress/.htaccess ]; \
# 	{ \
# 		echo '# BEGIN WordPress'; \
# 		echo ''; \
# 		echo 'RewriteEngine On'; \
# 		echo 'RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]'; \
# 		echo 'RewriteBase /'; \
# 		echo 'RewriteRule ^index\.php$ - [L]'; \
# 		echo 'RewriteCond %{REQUEST_FILENAME} !-f'; \
# 		echo 'RewriteCond %{REQUEST_FILENAME} !-d'; \
# 		echo 'RewriteRule . /index.php [L]'; \
# 		echo ''; \
# 		echo '# END WordPress'; \
# 	} > /usr/src/wordpress/.htaccess; \
# 	\
# 	chown -R www-data:www-data /usr/src/wordpress; \
# # pre-create wp-content (and single-level children) for folks who want to bind-mount themes, etc so permissions are pre-created properly instead of root:root
# # wp-content/cache: https://github.com/docker-library/wordpress/issues/534#issuecomment-705733507
# 	mkdir wp-content; \
# 	for dir in /usr/src/wordpress/wp-content/*/ cache; do \
# 		dir="$(basename "${dir%/}")"; \
# 		mkdir "wp-content/$dir"; \
# 	done; \
# 	chown -R www-data:www-data wp-content; \
# 	chmod -R 1777 wp-content

# VOLUME /var/www/html

# COPY --chown=www-data:www-data wp-config-docker.php /usr/src/wordpress/
# COPY ./docker-entrypoint.sh /usr/local/bin/

# ENTRYPOINT ["docker-entrypoint.sh"]
# CMD ["php-fpm"]

# =============================

# FROM alpine:3.19

# # php81-fpm
# RUN apk add  tar wget \
#     && wget https://wordpress.org/latest.tar.gz \
#     && tar -xzvf latest.tar.gz

# CMD [ "sleep", "infinity" ]

# ENV PHP_CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
# ENV PHPIZE_DEPS="autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c"
# ENV PHP_LDFLAGS="-Wl,-O1 -pie"
# ENV GPG_KEYS="528995BFEDFBA7191D46839EF9BA0ADA31CBD89E 39B641343D8C104B2B146DC3F9C39DC0B9698544 F1F692238FBC1666E5A5CCD4199F9DFEF6FFBAFD"
# ENV PHP_VERSION="8.1.26"
# ENV PHP_URL="https://www.php.net/distributions/php-8.1.26.tar.xz" PHP_ASC_URL="https://www.php.net/distributions/php-8.1.26.tar.xz.asc"
# ENV PHP_SHA256="17f87133596449327451ad4b8d9911bfaea59ff5109f3a6f2bb679f967a8ea0f"
# RUN /bin/sh -c set -eux; apk add --no-cache --virtual .fetch-deps gnupg; mkdir -p /usr/src; cd /usr/src; curl -fsSL -o php.tar.xz "$PHP_URL"; if [ -n "$PHP_SHA256" ]; then echo "$PHP_SHA256 *php.tar.xz" | sha256sum -c -; fi; if [ -n "$PHP_ASC_URL" ]; then curl -fsSL -o php.tar.xz.asc "$PHP_ASC_URL"; export GNUPGHOME="$(mktemp -d)"; for key in $GPG_KEYS; do gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key"; done; gpg --batch --verify php.tar.xz.asc php.tar.xz; gpgconf --kill all; rm -rf "$GNUPGHOME"; fi; apk del --no-network .fetch-deps
# COPY file:ce57c04b70896f77cc11eb2766417d8a1240fcffe5bba92179ec78c458844110 in /usr/local/bin/
# RUN /bin/sh -c set -eux; apk add --no-cache --virtual .build-deps $PHPIZE_DEPS argon2-dev coreutils curl-dev gnu-libiconv-dev libsodium-dev libxml2-dev linux-headers oniguruma-dev openssl-dev readline-dev sqlite-dev ; rm -vf /usr/include/iconv.h; export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" ; docker-php-source extract; cd /usr/src/php; gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"; ./configure --build="$gnuArch" --with-config-file-path="$PHP_INI_DIR" --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" --enable-option-checking=fatal --with-mhash --with-pic --enable-ftp --enable-mbstring --enable-mysqlnd --with-password-argon2 --with-sodium=shared --with-pdo-sqlite=/usr --with-sqlite3=/usr --with-curl --with-iconv=/usr --with-openssl --with-readline --with-zlib --disable-phpdbg --with-pear $(test "$gnuArch" = 's390x-linux-musl' && echo '--without-pcre-jit') --disable-cgi --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data ; make -j "$(nproc)"; find -type f -name '*.a' -delete; make install; find /usr/local -type f -perm '/0111' -exec sh -euxc ' strip --strip-all "$@" || : ' -- '{}' + ; make clean; cp -v php.ini-* "$PHP_INI_DIR/"; cd /; docker-php-source delete; runDeps="$( scanelf --needed --nobanner --format '%n#p' --recursive /usr/local | tr ',' '\n' | sort -u | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' )"; apk add --no-cache $runDeps; apk del --no-network .build-deps; pecl update-channels; rm -rf /tmp/pear ~/.pearrc; php --version
# COPY multi:869bde9dbeae74886a05c9e2107b3e3b4877116db8c6d9adbaff2719f9fb5262 in /usr/local/bin/
# RUN /bin/sh -c docker-php-ext-enable sodium
# ENTRYPOINT ["docker-php-entrypoint"]
# WORKDIR /var/www/html
# RUN /bin/sh -c set -eux; cd /usr/local/etc; if [ -d php-fpm.d ]; then sed 's!=NONE/!=!g' php-fpm.conf.default | tee php-fpm.conf > /dev/null; cp php-fpm.d/www.conf.default php-fpm.d/www.conf; else mkdir php-fpm.d; cp php-fpm.conf.default php-fpm.d/www.conf; { echo '[global]'; echo 'include=etc/php-fpm.d/*.conf'; } | tee php-fpm.conf; fi; { echo '[global]'; echo 'error_log = /proc/self/fd/2'; echo; echo '; https://github.com/docker-library/php/pull/725#issuecomment-443540114'; echo 'log_limit = 8192'; echo; echo '[www]'; echo '; php-fpm closes STDOUT on startup, so sending logs to /proc/self/fd/1 does not work.'; echo '; https://bugs.php.net/bug.php?id=73886'; echo 'access.log = /proc/self/fd/2'; echo; echo 'clear_env = no'; echo; echo '; Ensure worker stdout and stderr are sent to the main error log.'; echo 'catch_workers_output = yes'; echo 'decorate_workers_output = no'; } | tee php-fpm.d/docker.conf; { echo '[global]'; echo 'daemonize = no'; echo; echo '[www]'; echo 'listen = 9000'; } | tee php-fpm.d/zz-docker.conf; mkdir -p "$PHP_INI_DIR/conf.d"; { echo '; https://github.com/docker-library/php/issues/878#issuecomment-938595965'; echo 'fastcgi.logging = Off'; } > "$PHP_INI_DIR/conf.d/docker-fpm.ini"
# STOPSIGNAL SIGQUIT
# EXPOSE 9000

# CMD ["php-fpm"]