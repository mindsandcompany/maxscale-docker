REGISTRY ?= mncregistry:30500
IMAGE_NAME := mariadb/maxscale
VERSION := 24.02.4

LOCAL_IMAGE := $(REGISTRY)/$(IMAGE_NAME):$(VERSION)

.PHONY: help

help:
	@echo "Usage: make build-image [REGISTRY=<image registry>]"

build:
	docker build -f maxscale/Dockerfile maxscale -t $(LOCAL_IMAGE) --build-arg VERSION=$(VERSION) --build-arg GIT_COMMIT=$(shell git rev-list -1 HEAD) --build-arg GIT_TREE_STATE=$(shell (git status --porcelain | grep -q .) && echo -dirty) --build-arg BUILD_TIME=$(shell date -u +%Y-%m-%d_%H:%M:%S)

push:
	docker push $(LOCAL_IMAGE)

save:
	docker save $(LOCAL_IMAGE) -o maxscale_$(VERSION).tar