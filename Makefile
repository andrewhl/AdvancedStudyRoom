db_create:
	docker-compose run --rm web rake db:create

db_migrate:
	docker-compose run --rm web rake db:migrate

db_seed:
	docker-compose run --rm web rake db:seed

.PHONY: all
