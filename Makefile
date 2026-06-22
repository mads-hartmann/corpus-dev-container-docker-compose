.PHONY: check clean run

check:
	./scripts/check.sh

run:
	docker compose up --watch

clean:
	docker compose down -v
