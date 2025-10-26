#!/bin/bash
set -e

ROOT_PASSWORD=$(cat ../secrets/db_root_password.txt)
WORDPRESS_DB_PASSWORD=$(cat ../secrets/db_password.txt)

DB_DATABASE=$DB_NAME 
WORDPRESS_DB_USER=$WORDPRESS_DB_USER

echo "Starting MariaDB setup and configuration..."

if [ ! -d "/var/lib/mysql/$DB_DATABASE" ]; then
    mysql -u root -p"${ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${DB_DATABASE}\`;"
    
    mysql -u root -p"${ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
    
    mysql -u root -p"${ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${DB_DATABASE}\`.* TO '${WORDPRESS_DB_USER}'@'%';"
    
    mysql -u root -p"${ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

    echo "Database and user setup successful for $DB_DATABASE."
else
    echo "Database directory for $DB_DATABASE already exists. Skipping database and user creation."
fi

exec mariadbd