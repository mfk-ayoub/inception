
if [ ! -f /etc/ssl/certs/nginx-selfsigned.crt ]; then
    mkdir -p /etc/ssl/private
    python3 /tools/generate_ssl.py
fi

nginx -g "daemon off;"
