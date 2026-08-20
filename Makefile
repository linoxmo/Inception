NAME = inception
COMPOSE = sudo docker compose -f docker-compose.yaml

all: up

up:
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

restart:
	$(COMPOSE) restart

logs:
	$(COMPOSE) logs

ps:
	$(COMPOSE) ps

clean:
	$(COMPOSE) down --volumes

fclean:
	$(COMPOSE) down --volumes --rmi all

re: fclean all
