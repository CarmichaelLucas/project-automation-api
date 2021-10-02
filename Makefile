# Arquivo de configuração

build:
	@docker-compose build

up:
	@docker-compose up -d

down:
	@docker-compose down

rm:
	@docker image rmi yapay/qa

test:
	@docker-compose run rspec bundle exec rspec

sh:
	@docker container exec -it rspec sh