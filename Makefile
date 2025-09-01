
.PHONY: build up down restart 

build:
	cd srcs && docker compose build

up:
	cd srcs && docker compose up

upd:
	cd srcs && docker compose up --build

down:
	cd srcs && docker compose down

restart:
	cd srcs && docker compose down
	cd srcs && docker compose up --build

