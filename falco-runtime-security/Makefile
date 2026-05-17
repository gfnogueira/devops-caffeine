SHELL := /usr/bin/env bash
COMPOSE := docker compose

.PHONY: up down restart status logs events smoke

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down -v

restart:
	$(COMPOSE) restart falco

status:
	$(COMPOSE) ps

logs:
	$(COMPOSE) logs -f --tail=200 falco

events:
	$(COMPOSE) exec -T falco tail -f /var/log/falco/falco-events.log

smoke:
	$(COMPOSE) exec -T falco falco --version
