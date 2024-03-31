# Variables
PYTHON := python3
FLAKE8 := flake8
DOCKER := docker
GIT := git
REPO := your-dockerhub-username/your-repo-name
PORT := 5000

# Targets
.PHONY: lint test build docker-build docker-run docker-stop deploy

lint:
	@echo "Linting code..."
	@$(FLAKE8) .

test:
	@echo "Running tests..."
	@$(PYTHON) -m pytest

build: lint test
	@echo "Building the application..."

docker-build:
	@echo "Building Docker image..."
	@$(DOCKER) build -t $(REPO) .

docker-run: docker-build
	@echo "Running Docker container..."
	@$(DOCKER) run -d -p $(PORT):$(PORT) $(REPO)

docker-stop:
	@echo "Stopping Docker container..."
	@CONTAINER_ID=$$($(DOCKER) ps -q --filter ancestor=$(REPO)); \
	if [ ! -z "$$CONTAINER_ID" ]; then \
		$(DOCKER) stop $$CONTAINER_ID; \
		echo "Container $$CONTAINER_ID stopped."; \
	else \
		echo "No running container found."; \
	fi

deploy: docker-build
	@echo "Pushing Docker image to Docker Hub..."
	@$(DOCKER) push $(REPO)