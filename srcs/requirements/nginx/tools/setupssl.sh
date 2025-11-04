#!/bin/bash

set -e


mkdir -p /etc/ssl/private/
mkdir -p /etc/ssl/certs/


echo "Generating SSL certificate..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=ma/ST=IDF/L=bg/O=1337/OU=1337/CN=ayel-mou.42.fr"

echo "SSL Generated. Starting Nginx..."

exec nginx -g "daemon off;"
