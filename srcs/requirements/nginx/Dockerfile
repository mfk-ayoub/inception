FROM debian:latest

WORKDIR /app

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

COPY tools /tools
RUN chmod +x /tools/script.sh

EXPOSE 443

ENTRYPOINT [ "bash" ]
CMD ["/tools/script.sh"]
