#!/bin/sh +x

if [ ! -e "$WP_DATA_PATH/wp-config.php" ]; then
	wp core download --path=$WP_DATA_PATH --allow-root
	echo "define( 'WP_DEBUG', true );" >> /tmp/.testphp && \
	echo "define( 'WP_DEBUG_LOG', true );" >> /tmp/.testphp && \
	wp config create \
		--path=$WP_DATA_PATH \
		--dbname=$DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_PASS \
		--dbhost=$DB_HOST \
		--extra-php < /tmp/.testphp && \
	rm /tmp/.testphp

	wp core install \
		--path=$WP_DATA_PATH \
		--url=$WP_URL \
		--title="$WP_TITLE" \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--locale="en_JP" \
		--skip-email
	wp user create \
		$WP_EDITOR_USER \
		$WP_EDITOR_EMAIL \
		--path=$WP_DATA_PATH \
		--role=author \
		--user_pass=$WP_EDITOR_PASSWORD
fi

exec php-fpm81 --nodaemonize

# wp core install --path=$WP_DATA_PATH --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --locale="en_JP" --skip-email
# wp user create $WP_EDITOR_USER $WP_EDITOR_EMAIL --path=$WP_DATA_PATH --role=author --user_pass=$WP_EDITOR_PASSWORD
# wp option update siteurl $WP_URL$WP_DATA_PATH
