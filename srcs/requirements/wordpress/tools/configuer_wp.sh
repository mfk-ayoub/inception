#!/bin/bash

WP_DB_PASSWORD=$(cat /run/secrets/wp_db_pass)
WP_ADMIN_USER=$(cat /run/secrets/wp_admin_user)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_pass)
WP_USER_PASS=$(cat /run/secrets/wp_user_cred)


if [ ! -f "/var/www/html/wp-config.php" ]; then


    while ! nc -z $DB_HOST $DB_PORT; do
        echo "Waiting for MariaDB to be ready at $DB_HOST:$DB_PORT..."
        sleep 2
    done
    echo "MariaDB is ready."

    wp core download --allow-root --path=/var/www/html

    wp config create --allow-root \
        --dbname=$DB_NAME \
        --dbuser=$WORDPRESS_DB_USER \
        --dbpass=$WP_DB_PASSWORD \
        --dbhost=$DB_HOST:$DB_PORT \
        --path=/var/www/html

    wp core install --allow-root \
        --path=/var/www/html \
        --url=https://$DOMAIN_NAME \
        --title="$WP_TITLE" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL

    wp user create --allow-root \
        --path=/var/www/html \
        $WP_USER $WP_EMAIL \
        --user_pass=$WP_USER_PASS \
        --role=author

    echo "WordPress is set up."
else
    echo "WordPress is already installed."
fi

exec /usr/sbin/php-fpm -F