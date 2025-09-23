
.PHONY: build up down restart 

SRC := srcs
COMPOSE = docker compose

image:
	docker image ls -a
container:
	docker container ls -a

build:
	cd $(SRC) && $(COMPOSE) build

up:
	cd $(SRC) && $(COMPOSE) up

upd:
	cd $(SRC) && $(COMPOSE) up --build

down:
	cd $(SRC) && $(COMPOSE) down

restart:
	cd $(SRC) && $(COMPOSE) down
	cd $(SRC) && $(COMPOSE) up --build

