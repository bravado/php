.PHONY: build push build-mailout push-mailout

default: build

build:
	docker build -t bravado/apache .

push: build
	docker push bravado/apache

test: build
	bash test.sh
