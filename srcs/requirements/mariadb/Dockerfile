FROM debian:latest

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
        mariadb-server \
        mariadb-client 

COPY tools /tools

RUN chmod +x /tools/setup.sh

EXPOSE 3306

ENTRYPOINT [ "setup.sh" ]