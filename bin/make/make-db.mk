db-migrate:
	docker-compose exec app rails db:migrate

db-seed:
	docker-compose exec app rails db:seed

db-init: db-migrate db-seed

