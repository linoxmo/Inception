NAME = inception

COMPOSE = docker compose -f docker-compose.yaml

DATA_DIR = $(HOME)/data
WP_DATA = $(DATA_DIR)/wordpress
DB_DATA = $(DATA_DIR)/mariadb

all: up

$(WP_DATA):
	mkdir -p $(WP_DATA)

$(DB_DATA):
	mkdir -p $(DB_DATA)

up: $(WP_DATA) $(DB_DATA)
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
	$(COMPOSE) ps -a

clean: down
	$(COMPOSE) down --volumes --remove-orphans
	-docker rm -f $$(docker ps -aq --filter "name=nginx" --filter "name=wordpress" --filter "name=mariadb") 2>/dev/null

fclean: clean
	$(COMPOSE) down --volumes --rmi all --remove-orphans
	-docker system prune -af --volumes
	-rm -rf $(DATA_DIR)

re : clean all

reset: fclean all

.PHONY: all up down start stop restart logs ps clean fclean re
