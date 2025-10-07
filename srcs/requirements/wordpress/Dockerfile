FROM debian:latest

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y php-fpm php-mysql curl wget tar && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz





EXPOSE 9000



