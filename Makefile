# Makefile for globomap-dev

# Pip executable path
PIP := $(shell which pip)

help:
	@echo
	@echo "Please use 'make <target>' where <target> is one of"
	@echo

	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

dynamic_ports: ## Run containers
	@echo "Setting ports..."
	@echo "Setting ports Globomap API..."
	@cd globomap-api; make dynamic_ports; cd ..
	@echo "Setting ports Globomap Loader API..."
	@cd globomap-loader-api; make dynamic_ports; cd ..
	@echo "Setting ports Globomap UI..."
	@cd globomap-ui; make dynamic_ports; cd ..

containers_start: ## Run containers
	@echo "Running containers..."
	@echo "Running Globomap API..."
	@cd globomap-api; make containers_start; cd ..
	@echo "Running Globomap Loader..."
	cd globomap-loader; make containers_start; cd ..
	@echo "Running Globomap Loader API..."
	cd globomap-loader-api; make containers_start; cd ..
	@echo "Running Globomap UI..."
	cd globomap-ui; make containers_start; cd ..

containers_build: ## Build containers
	@echo "Building docker..."
	@echo "Building Globomap API..."
	@cd globomap-api; make containers_build; cd ..
	@echo "Building Globomap Loader..."
	cd globomap-loader; make containers_build; cd ..
	@echo "Building Globomap Loader API..."
	cd globomap-loader-api; make containers_build; cd ..
	@echo "Building Globomap UI..."
	cd globomap-ui; make containers_build; cd ..

containers_stop: ## Stop containers
	@echo "Stopping Globomap API..."
	@cd globomap-api; make containers_stop; cd ..
	@echo "Stopping Globomap Loader..."
	cd globomap-loader; make containers_stop; cd ..
	@echo "Stopping Globomap Loader API..."
	cd globomap-loader-api; make containers_stop; cd ..
	@echo "Stopping Globomap UI..."
	cd globomap-ui; make containers_stop; cd ..

containers_clean: ## Stop containers
	@echo "Cleaning Globomap API..."
	@cd globomap-api; make containers_clean; cd ..
	@echo "Cleaning Globomap Loader..."
	cd globomap-loader; make containers_clean; cd ..
	@echo "Cleaning Globomap Loader API..."
	cd globomap-loader-api; make containers_clean; cd ..
	@echo "Cleaning Globomap UI..."
	cd globomap-ui; make containers_clean; cd ..

git_update: ## Update submodules
	git submodule init
	git submodule update --recursive --remote

setup: git_update dynamic_ports containers_build containers_start ## Setup project
