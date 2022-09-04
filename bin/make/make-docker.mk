init:
	ln docker/docker-compose.dev.yml docker-compose.yml && cp docker/.env.sample .env

build:
	docker-compose up --no-start --force-recreate --build

attach:
	docker attach $$(docker-compose ps -q app)

rebuild:
	docker-compose build --force-rm --no-cache

up:
	docker-compose up -d

down:
	docker-compose down --remove-orphans

run: down up

console:
	docker-compose exec app rails console

compile: init build
