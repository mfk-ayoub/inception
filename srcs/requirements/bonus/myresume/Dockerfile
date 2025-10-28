FROM debian:bullseye

RUN apt update && apt install -y nginx 

COPY site/ /usr/share/nginx/html/
COPY conf/ayoub.conf /etc/nginx/http.d/default.conf


RUN chmod 777 /etc/nginx/http.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
