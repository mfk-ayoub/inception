FROM debian:latest

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
    && mkdir -p /var/lib/mysql

COPY conf/db.conf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools /tools
RUN chmod +x /tools/create_db.sh


CMD ["/tools/create_db.sh"]
