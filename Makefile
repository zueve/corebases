.PHONY: help

CURRENT_DIR = $(shell pwd)
GREEN = \033[0;32m
YELLOW = \033[0;33m
NC = \033[0m


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-17s\033[0m %s\n", $$1, $$2}'

# ============= General use-cases =============

check: linting test ## Linting python code and run tests in one command

linting: flake8 isort black mypy ## Linting python code

# ============= General commands =============

install: ## Install all dependencies (need poetry!)
	@echo "\n${GREEN}Installing project dependencies${NC}"
	poetry install
	poetry show


clean: ## Clear temporary information, stop Docker containers
	@echo "\n${YELLOW}Clear cache directories${NC}"
	rm -rf .mypy_cache .pytest_cache .coverage
	poetry run pyclean .


test: ## Run unit-tests
	@echo "\n${GREEN}Running unit-tests${NC}"


fmt: ## Auto formatting python code
	@echo "\n${GREEN}Auto formatting python code with isort${NC}"
	poetry run isort .
	@echo "\n${GREEN}Auto formatting python code with black${NC}"
	poetry run black .

# ============= Other project specific commands =============

flake8: ## Linting python code with flake8
	@echo "\n${GREEN}Linting python code with flake8${NC}"
	poetry run flake8 corebases

isort: ## Linting python code with isort
	@echo "\n${GREEN}Linting python code with isort${NC}"
	poetry run isort corebases --check

black: ## Linting python code with black
	@echo "\n${GREEN}Linting python code with black${NC}"
	poetry run black --check corebases

mypy: ## Linting python code with mypy
	@echo "\n${GREEN}Linting python code with mypy${NC}"
	poetry run mypy corebases
