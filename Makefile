NAME = inception
COMPOSE = docker compose -f docker-compose.yaml
TO_LOG = | tee log.txt

all: up 

up:
	$(COMPOSE) up -d --build 2>&1 $(TO_LOG)

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
