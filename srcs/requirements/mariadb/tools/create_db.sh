if [ ! -d "/var/lib/mysql/$DB_DATABASE" ]; then

mysql -uroot -p"${ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${DB_DATABASE}\`;"
mysql -uroot -p"${ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
mysql -uroot -p"${ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${DB_DATABASE}\`.* TO '${WORDPRESS_DB_USER}'@'%';"
mysql -uroot -p"${ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
