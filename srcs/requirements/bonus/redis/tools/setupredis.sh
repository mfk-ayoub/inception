#!/bin/bash
set -e

if [ -f /run/secrets/redis_password ]; then
    REDIS_PASSWORD=$(cat /run/secrets/redis_password)

    sed -i "s/requirepass .*/requirepass $REDIS_PASSWORD/" /etc/redis/redis.conf
else
    echo "Redis password secret not found!"
    exit 1
fi

exec redis-server /etc/redis/redis.conf
