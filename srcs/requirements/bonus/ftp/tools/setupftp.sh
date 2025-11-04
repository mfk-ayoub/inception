#!/bin/sh
set -e

FTP_HOME_DIR="/var/www/wordpress"

echo "Starting script ..." 

mkdir -p $FTP_HOME_DIR


echo /bin/false >> /etc/shells

useradd -d $FTP_HOME_DIR -s /bin/false ${FTP_USER}

echo "user creds : ${FTP_USER}:${FTP_PASS}" 
echo "${FTP_USER}:${FTP_PASS}" | chpasswd

chown -R ${FTP_USER}:${FTP_USER} $FTP_HOME_DIR
chmod 755 $FTP_HOME_DIR

echo "Starting FTP server ..."

exec /usr/sbin/vsftpd /etc/vsftpd.conf