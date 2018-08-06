.DEFAULT_GOAL := help

run: ## Run
	docker run --rm -it -v `pwd`:/app -p 4567:4567 . /bin/bash

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

