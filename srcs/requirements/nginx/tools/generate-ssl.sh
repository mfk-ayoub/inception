#!/bin/bash

set -e

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=en/ST=IDF/L=bg/O=1337/OU=1337/CN=ayel-mou.1337.ma"

exec  nginx -g "daemon off;"

