.PHONY: build push build-mailout push-mailout
DOCKER_IMAGE ?= registry.gitlab.com/prosoma/php
default: build

init:
	$(eval GIT_BRANCH=$(shell git rev-parse --abbrev-ref HEAD))

build: init
	docker build -t ${DOCKER_IMAGE}:${GIT_BRANCH} .

test: build
	bash test.sh ${DOCKER_IMAGE} ${GIT_BRANCH}

run: PUID=1000
run: PGID=1000
run: USER=app
run: init
	docker run -it --user=${USER} --rm -e NR_INSTALL_KEY=asdf -e PUID=${PUID} -e PGID=${PGID} ${DOCKER_IMAGE}:${GIT_BRANCH} ${CMD}

pull:
	docker pull registry.gitlab.com/prosoma/debian:stretch

push: init
	docker push ${DOCKER_IMAGE}:${GIT_BRANCH}
