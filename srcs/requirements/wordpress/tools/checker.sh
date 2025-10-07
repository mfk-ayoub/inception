#/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then
  cd /var/www/html
  curl -O https://wordpress.org/latest.tar.gz
  tar -xzf latest.tar.gz
  mv wordpress/* .
  rm -rf wordpress latest.tar.gz
  chown -R www-data:www-data /var/www/html
  chmod -R 755 /var/www/html

fi
