FROM debian:latest

RUN apt update -y && \
    apt install -y nginx openssl curl vim && \
    rm -rf /var/lib/apt/lists/*

COPY tools/generate-ssl.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/generate-ssl.sh


COPY	conf/default.conf /etc/nginx/conf.d/default.conf
RUN     chmod 777 /etc/nginx/conf.d/default.conf

CMD  [ "/usr/local/bin/generate-ssl.sh" ]




