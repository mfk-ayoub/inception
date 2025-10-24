FROM debian:latest

RUN apt-get update -y && \
    apt-get install -y \
        php-fpm \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html

COPY tools/configuer_wp.sh /usr/bin/configuer_wp.sh
RUN chmod +x /usr/bin/configuer_wp.sh

CMD ["/usr/bin/configuer_wp.sh"]
