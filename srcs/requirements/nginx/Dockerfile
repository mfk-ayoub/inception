FROM debian:latest

WORKDIR /app

RUN apt-get update -y && \
    apt-get install -y \
        nginx \
        openssl \
        procps \
        vim \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \ 
    -keyout /etc/ssl/private/ayel-mou.key \
    -out /etc/ssl/certs/ayel-mou.crt \
    -subj="/C=MA/ST=benguerir/L=benguerir/O=1337 School/OU=ayel-mou/CN=ayel-mou.42.fr"

    COPY tools/script.sh /tools/script.sh
RUN chmod +x /tools/script.sh

COPY conf/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["/tools/script.sh"]