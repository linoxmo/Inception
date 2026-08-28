NAME = inception

COMPOSE = docker compose -f docker-compose.yaml

DATA_DIR = /home/tmagoudi42/Downloads/Inception-main/data
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
	$(COMPOSE) ps

clean:
	$(COMPOSE) down --volumes

fclean:
	$(COMPOSE) down --volumes --rmi all

re: fclean all
