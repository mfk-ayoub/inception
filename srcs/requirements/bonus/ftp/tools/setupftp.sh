#!/bin/sh
set -e

# Hada howa l-dossier l-s7i7 (machi /ftp)
FTP_HOME_DIR="/var/www/wordpress"

echo "Starting script ..." 

# Kan-creer-iw l-dossier /var/www/wordpress (ila makanx)
mkdir -p $FTP_HOME_DIR

# === HNA KAYN L-FIX ===
# Kan-zidn l-shell '/bin/false' l-lista dyal l-shells l-mesmou7a
# Hakda PAM (security) makaybqa y-blocki l-user dyalna
echo /bin/false >> /etc/shells
# --- FIN DYAL L-FIX ---

# Kan-creer-iw l-user o kan3tiwh l-home directory l-s7i7
useradd -d $FTP_HOME_DIR -s /bin/false ${FTP_USER}

echo "user creds : ${FTP_USER}:${FTP_PASS}" 
echo "${FTP_USER}:${FTP_PASS}" | chpasswd

# Kan3tiw l-permissions l-dossier l-s7i7
# (chown howa l-mohim, chmod 755 mzyana 7it 7ydna l-write l-group/other)
chown -R ${FTP_USER}:${FTP_USER} $FTP_HOME_DIR
chmod 755 $FTP_HOME_DIR

echo "Starting FTP server ..."

# Kan-demarréw l-server
exec /usr/sbin/vsftpd /etc/vsftpd.conf