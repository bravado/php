.PHONY: build push build-mailout push-mailout

default: build

build:
	docker build -t bravado/apache:php5 .

push: build
	docker push bravado/apache:php5

test: build
	bash test.sh php5
