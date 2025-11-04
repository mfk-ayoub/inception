

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y vsftpd lftp && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/vsftpd/empty


COPY conf/vsftpd.conf /etc/vsftpd.conf

COPY tools/setupftp.sh /usr/local/bin/setupftp.sh

RUN chmod +x /usr/local/bin/setupftp.sh


ENTRYPOINT ["/usr/local/bin/setupftp.sh"]