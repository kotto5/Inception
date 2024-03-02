TARGETS := ./srcs/compose.yml
VOLUME_DIR := /home/${USER}/data
VOLUME_DIR_WP := $(VOLUME_DIR)/wordpress
VOLUME_DIR_DB := $(VOLUME_DIR)/mariadb

all:
	mkdir -p $(VOLUME_DIR_WP) $(VOLUME_DIR_DB)
	docker-compose -f $(TARGETS) up -d

d:
	docker-compose -f $(TARGETS) down

clean: d
	docker-compose -f $(TARGETS) down --rmi all --volumes

fclean: clean
	sudo rm -rf $(VOLUME_DIR)/*

re: clean all
