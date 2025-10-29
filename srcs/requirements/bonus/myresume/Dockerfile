FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

COPY conf/ayoub.conf /etc/nginx/conf.d/ayoub.conf
RUN chmod +x  /etc/nginx/conf.d/ayoub.conf

COPY site/ /var/www/html/


CMD ["nginx", "-g", "daemon off;"]