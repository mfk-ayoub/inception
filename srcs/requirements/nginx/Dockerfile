FROM debian:latest

RUN apt update -y && apt upgrade -y && apt install -y nginx

COPY . /tools 
RUN chmod +x /tools/script.sh

CMD ["script.sh"]