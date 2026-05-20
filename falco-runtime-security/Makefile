SHELL := /usr/bin/env bash
COMPOSE := docker compose

.PHONY: up down restart status logs events smoke reload outputs simulate validate health bench

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

reload:
	$(COMPOSE) kill -s SIGHUP falco

outputs:
	bash scripts/test_outputs.sh

simulate:
	bash scripts/simulate/run_all.sh

validate:
	cd scripts && python3 validate_detections.py

health:
	bash scripts/health_check.sh

bench:
	bash scripts/benchmark.sh
