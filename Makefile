TARGETS := ./srcs/compose.yml

all:
	docker-compose -f $(TARGETS) up -d

d:
	docker-compose -f $(TARGETS) down

clean: d
	docker-compose -f $(TARGETS) down --rmi all
	docker volume prune -f 

re: d all