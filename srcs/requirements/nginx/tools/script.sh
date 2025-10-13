#!/bin/bash
set -e

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/nginx/ssl/server.key \
-out /etc/nginx/ssl/server.crt \
-subj="/C=MA/ST=benguerir/L=benguerir/O=1337 School/OU=ayel-mou/CN=ayel-mou.42.fr"

exec nginx -g "daemon off;"