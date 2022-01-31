SHELL=/bin/bash
MICROPYTHON_VERSION=$(shell sed -n -e 's/^ENV MICROPYTHON_VERSION //p' Dockerfile)

.PHONY: all
all: build

.PHONY: build
build:
	@echo "build: building container"
	docker build -t jonathanfoster/micropython .
	docker tag jonathanfoster/micropython:latest jonathanfoster/micropython:$(MICROPYTHON_VERSION)

.PHONY: push
push:
	@echo "build: pushing container to docker hub"
	docker login -u jonathanfoster -p $(DOCKER_ACCESS_TOKEN)
	docker push jonathanfoster/micropython:latest
	docker push jonathanfoster/micropython:$(MICROPYTHON_VERSION)
