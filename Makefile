IMAGENAME = jeboehm/shopware
VERSIONS  = tags/*
LATEST   := $(shell find tags -type d -mindepth 1 | sort --version-sort | tail -n 1)

.PHONY: latest
latest:
	make $(LATEST)

.PHONY: ci
ci: test clean

.PHONY: test
test: latest
	docker-compose up -d percona
	docker-compose run --rm shopware test

.PHONY:
clean:
	docker-compose down -v --rmi all

.PHONY: baseimage
baseimage:
	docker build -t $(IMAGENAME):base .

.PHONY: tags/%
tags/%: baseimage
	cd $@; docker build -t $(IMAGENAME):$(shell basename $@) .

