PHONY: build
build:
	docker-compose build

PHONY: run
run:
	docker-compose up

PHONY: migrate
migrate:
	docker-compose run web db:migrate

PHONY: create-migrate
create-migrate:
	docker-compose run web generate migration ${name}
