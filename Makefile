all:
	mkdir -p /home/inception/Desktop/inception/mariadb
	mkdir -p /home/inception/Desktop/inception/wordpress
	
	sudo chown -R inception:inception  /home/inception/Desktop/inception/mariadb
	sudo chown -R inception:inception /home/inception/Desktop/inception/wordpress
	cd srcs && docker compose up --build -d
down:
	cd srcs && docker compose down

clean:
	cd srcs && docker compose down --rmi all -v

fclean:
	cd srcs &&  docker compose down --rmi all -v
	sudo rm -rf /home/inception/Desktop/inception/mariadb
	sudo rm -rf /home/inception/Desktop/inception/wordpress

ps:
	docker ps 

v:
	docker volume ls
net:
	docker network ls
	

re: fclean all 

.PHONY: all down clean fclean re





