#!/bin/bash
set -e

mkdir -p /var/www/wordpress
cd /var/www/wordpress


WORDPRESS_DB_PASSWORD="$(cat /run/secrets/db_password)"
WORDPRESS_DB_USER="$(sed -n '1p' /run/secrets/user_and_passowrd)"
USER_PASSWORD="$(sed -n '2p' /run/secrets/user_and_passowrd)"
REDIS_PASSWORD="$(cat /run/secrets/redis_password)"



echo "Waiting for MariaDB connection..."
while ! mariadb -h mariadb -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" --silent; do
    echo "Retrying MariaDB connection...";
    sleep 2
done
echo "MariaDB connection successful."


if [ ! -f "wp-config.php" ]; then
  
    echo "wp-config.php not found. Starting fresh WordPress installation..."
    
    echo "Downloading WordPress core files..."
    wp core download --allow-root

    echo "Creating WordPress config..."
    wp config create --allow-root \
        --dbname="$DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST"

    echo "Installing WordPress..."
    wp core install --allow-root \
        --url="$URL" \
        --title="$TITLE" \
        --admin_user="$WORDPRESS_DB_USER" \
        --admin_password="$WORDPRESS_DB_PASSWORD" \
        --admin_email="$ADMIN_EMAIL"

    echo "Creating author user..."
    wp user create --allow-root \
        "$USER" "$USER_EMAIL" \
        --role=author \
        --user_pass="$USER_PASSWORD"

    echo "Installing and configuring Redis Object Cache..."
    wp plugin install redis-cache --activate --allow-root
    wp config set WP_CACHE true --raw --allow-root
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --allow-root
    wp config set WP_REDIS_PASSWORD "$REDIS_PASSWORD" --allow-root
    wp redis enable --allow-root
    echo "Redis Cache enabled for new install."

else
    echo "WordPress (wp-config.php) already exists."


    if ! wp plugin is-active redis-cache --allow-root; then
        
        

        wp plugin install redis-cache --activate --allow-root
        

        wp config set WP_CACHE true --raw --allow-root
        wp config set WP_REDIS_HOST redis --allow-root
        wp config set WP_REDIS_PORT 6379 --allow-root
        wp config set WP_REDIS_PASSWORD "$REDIS_PASSWORD" --allow-root
        
        wp redis enable --allow-root
    else
        echo "Redis plugin is already active."
    fi
fi


chown -R www-data:www-data /var/www/wordpress

echo "Starting PHP-FPM..."
exec php-fpm7.4 -F