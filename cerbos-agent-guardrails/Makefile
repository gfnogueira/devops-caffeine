.PHONY: up down ping test demo demo-tools demo-rag

up:
	docker compose up -d
	@sleep 2

down:
	docker compose down -v

ping:
	@curl -sf http://localhost:3592/_cerbos/health && echo

test:
	docker compose exec cerbos cerbos compile /policies --tests /policies

demo: demo-tools demo-rag

demo-tools:
	python -m scripts.demo_tool_gate

demo-rag:
	python -m scripts.demo_rag_filter
