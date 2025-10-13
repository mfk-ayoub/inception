
FROM debian:latest

RUN apt update && apt install -y nginx  openssl

COPY	conf/default.conf /etc/nginx/conf.d/default.conf
RUN     chmod 777 /etc/nginx/conf.d/default.conf

EXPOSE 443

COPY tools/script.sh /usr/local/bin/setupssl.sh
RUN chmod +x /usr/local/bin/setupssl.sh

CMD ["/usr/local/bin/setupssl.sh"]
