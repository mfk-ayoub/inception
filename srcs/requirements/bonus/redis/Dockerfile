FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    redis-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

COPY conf/redis.conf /etc/redis/redis.conf
COPY tools/setupredis.sh /usr/local/bin/start_redis.sh

RUN chmod +x /usr/local/bin/start_redis.sh


CMD ["/usr/local/bin/start_redis.sh"]
