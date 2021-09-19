DOCKER_IMAGE ?= bravado/php
GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)
DOCKER_TAG ?= $(DOCKER_IMAGE):$(GIT_BRANCH)

.PHONY: build push test build-dev
default: build

build:
	docker build -t ${DOCKER_TAG} .

push: build
	docker push ${DOCKER_TAG}

build-dev:
	docker build -t ${DOCKER_TAG}-dev -f Dockerfile.dev .

push-dev: build-dev
	docker push ${DOCKER_TAG}-dev

test: build
	bash test.sh ${DOCKER_IMAGE} ${GIT_BRANCH}

start:
	docker-compose up -d

logs:
	docker-compose logs -f

shell:
	docker-compose exec php bash

pull:
	docker pull bravado/debian:buster
