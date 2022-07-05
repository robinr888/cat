APP_NAME=flaskapp
PORT=8000
DOCKER_REPO=localhost/catassignment

# DOCKER TASKS
# Build the container
build: ## Build the container
	docker build -t $(APP_NAME) .

build-nc: ## Build the container without caching
	docker build --no-cache -t $(APP_NAME) .

run: ## Run container on port configured in `config.env`
	docker run -i -t --rm  -p=$(PORT):$(PORT) --detach  --name="$(APP_NAME)" $(APP_NAME)


up: build run ## Run container on port configured in `config.env` (Alias to run)

stop: ## Stop and remove a running container
	docker stop $(APP_NAME)


# Docker tagging
tag: tag-latest  ## Generate container tags for the `{version}` ans `latest` tags

tag-latest: ## Generate container `{version}` tag
	@echo 'create tag latest'
	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):latest

push:
	docker push $(DOCKER_REPO)/$(APP_NAME):latest

test:
	[ -f /usr/local/bin/container-structure-test ] ||  bash setup.sh
	container-structure-test  test  -i $(DOCKER_REPO)/$(APP_NAME):latest -c app/test.yml

# tag-version: ## Generate container `latest` tag
# 	@echo 'create tag $(VERSION)'
# 	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):$(VERSION)





### Requires Docker daemon running on localhost 