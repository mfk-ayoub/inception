FROM debian:latest

WORKDIR /app

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

COPY tools /tools

RUN chmod +x /tools/script.sh

ENTRYPOINT [ "bash" ]
CMD ["/tools/script.sh"]
