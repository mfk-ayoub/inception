#!/bin/bash



WP_DB_PASSWORD=$(cat ../secrets/db_password.txt)
WP_USER_PASS=$(cat ../secrets/user_password.txt)
DB_ROOT_PASSWORD=$(cat ../secrets/db_root_password.txt)


WP_CLI_PHAR="wp-cli.phar"
WP_CLI_TARGET_PATH="/usr/local/bin/wp"



# 2. WP-CLI Check and Install Logic
if command -v wp &> /dev/null; then
    echo "WP-CLI is already installed."
    wp --info | grep 'WP-CLI version'
else
    echo "WP-CLI not found. Starting installation."

    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

    if [ ! -f "$WP_CLI_PHAR" ]; then
        echo "Error: Download of $WP_CLI_PHAR failed."
        exit 1
    fi

    chmod +x "$WP_CLI_PHAR"
    
    if sudo mv "$WP_CLI_PHAR" "$WP_CLI_TARGET_PATH"; then
        echo "WP-CLI installed successfully."
        
        if command -v wp &> /dev/null; then
            wp --info | grep 'WP-CLI version'
        else
            echo "Error: WP-CLI executable not found in PATH after move. Exiting."
            exit 1
        fi
    else
        echo "Error: Failed to move WP-CLI to $WP_CLI_TARGET_PATH (Requires sudo/root access). Exiting."
        exit 1
    fi
fi

# 3. WordPress Setup Logic
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "wp-config.php not found. Starting WordPress setup."

    # Wait for Database using netcat (nc)
    while ! nc -z $DB_HOST $DB_PORT; do
        echo "Waiting for MariaDB to be ready at $DB_HOST:$DB_PORT..."
        sleep 2
    done
    echo "MariaDB is ready."

    # Download WordPress core files
    wp core download --allow-root --path=/var/www/html

    # Create wp-config.php
    wp config create --allow-root \
        --dbname=$DB_NAME \
        --dbuser=$WORDPRESS_DB_USER \
        --dbpass=$WP_DB_PASSWORD \
        --dbhost=$DB_HOST:$DB_PORT \
        --path=/var/www/html

    # Install WordPress
    wp core install --allow-root \
        --path=/var/www/html \
        --url=https://$DOMAIN_NAME \
        --title="$WP_TITLE" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_DB_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL

    # Create Author User
    wp user create --allow-root \
        --path=/var/www/html \
        $WP_USER $WP_EMAIL \
        --user_pass=$WP_USER_PASS \
        --role=author

    echo "WordPress is set up."
else
    echo "WordPress is already installed."
fi

echo "Script completed. Starting php-fpm..."
exec /usr/sbin/php-fpm -F