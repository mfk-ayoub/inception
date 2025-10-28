FROM debian:bullseye

RUN apt update && apt install -y nginx 

COPY site/ /usr/share/nginx/html/
COPY conf/ayoub.conf /etc/nginx/sites-available/default

RUN chmod 777 /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]
