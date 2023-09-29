TARGETS := ./srcs/docker-compose.yml

all:
	docker-compose -f $(TARGETS) up -d

d:
	docker-compose -f $(TARGETS) down

re: d all