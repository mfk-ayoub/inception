FROM debian:latest



RUN apt-get update -y && \
    apt-get install -y \
        nginx \
        python3 \
        python3-pip \
        openssl \
        python3-cryptography \
        curl \
        nano && \
    rm -rf /var/lib/apt/lists/*


RUN rm -f /etc/nginx/conf.d/default.conf

RUN echo '<h1>allo </h1>' > /var/www/html/index.html
COPY tools /tools
RUN chmod +x /tools/setup_ssl.sh
RUN chmod +x /tools/generate_ssl.py

COPY conf/default.conf /etc/nginx/conf.d/default.conf


CMD ["/tools/setup_ssl.sh"]
