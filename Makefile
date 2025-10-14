: all build up upd down restart image container

SRC := srcs
COMPOSE := docker compose

all: build up

image:
	$(COMPOSE) -f $(SRC)/docker-compose.yml images

container:
	$(COMPOSE) -f $(SRC)/docker-compose.yml ps -a

build:
	$(COMPOSE) -f $(SRC)/docker-compose.yml build

up:
	$(COMPOSE) -f $(SRC)/docker-compose.yml up -d

upd:
	$(COMPOSE) -f $(SRC)/docker-compose.yml up --build -d

down:
	$(COMPOSE) -f $(SRC)/docker-compose.yml down

fdown:
	$(COMPOSE) -f $(SRC)/docker-compose.yml down --rmi all

ps:
	docker ps 
restart: down upd