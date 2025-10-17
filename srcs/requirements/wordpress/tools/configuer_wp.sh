#!/bin/bash

# L'variables dyal l'Database (khasshom ikounou f'Docker Compose dyalek)
# Wlahad l'exemple ghan3tihom chi defaults ila makaininch

if [ -z "$HOST_NAME" ]; then
    WORDPRESS_DB_HOST="mysql"
fi

# N'creeriw l'wp-config.php ila makaynch
if [ ! -f wp-config.php ]; then
    wp config create \
        --dbname="$DB_DATABASE" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root
fi

exec php-fpm