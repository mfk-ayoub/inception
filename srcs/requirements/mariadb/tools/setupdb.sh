#!/bin/bash
set -e

chown -R mysql:mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql

ROOT_PASSWORD="$(cat /run/secrets/db_root_password)"
WORDPRESS_DB_PASSWORD="$(cat /run/secrets/db_password)"

if [ ! -f "/var/lib/mysql/.initialized" ]; then

  mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal


  mysqld --user=mysql &

  while ! mysqladmin ping -u root ; do
      sleep 2
  done

  mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';"

  mysql -uroot -p"${ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${WORDPRESS_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

  mysqladmin -u root -p"${ROOT_PASSWORD}" shutdown

  touch /var/lib/mysql/.initialized
fi

exec mysqld