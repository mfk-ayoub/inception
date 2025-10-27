all:
	sudo mkdir -p /home/ayel-mou/data/mariadb
	sudo mkdir -p /home/ayel-mou/data/wordpress
	
	@cd srcs && docker compose up --build -d

down:
	@cd srcs && docker compose down

clean:
	@cd srcs && docker compose down --rmi all -v

fclean:
	@cd srcs && docker compose down --rmi all -v
	sudo rm -rf /home/ayel-mou/data/mariadb
	sudo rm -rf /home/ayel-mou/data/wordpress

ps:
	@cd srcs && docker compose ps 

volume:
	@docker volume ls

net:
	@docker compose -f srcs/docker-compose.yml networks

image:
	@docker compose -f srcs/docker-compose.yml images

container:
	@docker compose -f srcs/docker-compose.yml ps -a

logsm:
	@docker logs mariadb
logswp:
	@docker logs wordpress
logsn:
	@docker logs nginx
	
executenginx:
	@cd srcs &&  docker compose exec nginx  bash 

executewp:
	@cd srcs &&  docker compose exec wordpress  bash 

executemd:
	@cd srcs &&  docker compose exec mariadb  bash 
re: fclean all 

.PHONY: all down clean fclean re ps v net




