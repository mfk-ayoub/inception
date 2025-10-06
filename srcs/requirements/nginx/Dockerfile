FROM debian:latest

WORKDIR /app

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx python3 python3-pip openssl && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install cryptography

COPY tools /tools
RUN chmod +x /tools/*.sh

COPY conf/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["/tools/script.sh"]

