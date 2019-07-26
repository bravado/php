DOCKER_IMAGE ?= bravado/php
GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)
DOCKER_TAG ?= $(DOCKER_IMAGE):$(GIT_BRANCH)

.PHONY: build push test build-dev
default: build

build:
	docker build --cache-from ${DOCKER_TAG} -t ${DOCKER_TAG} .

build-dev:
	docker build --cache-from ${DOCKER_TAG}-dev -t ${DOCKER_TAG}-dev -f Dockerfile.dev .

test: build
	bash test.sh ${DOCKER_IMAGE} ${GIT_BRANCH}

run: PUID=1000
run: PGID=1000
run: USER=app
run:
	docker run -it --user=${USER} --rm -e PUID=${PUID} -e PGID=${PGID} ${DOCKER_TAG} ${CMD}

pull:
	docker pull bravado/debian:stretch
	docker pull ${DOCKER_TAG}
	docker pull ${DOCKER_TAG}-dev
