.PHONY: help build push save

REGISTRY ?= mncregistry:30500
UID ?= 1000
GID ?= 1000
UNAME ?= mnc_admin
GNAME ?= mnc_admin
SECURITY ?= true
IMAGE_NAME := mariadb-maxscale
VERSION := 24.02.4

ifeq ($(SECURITY), false)
LOCAL_IMAGE := $(REGISTRY)/$(IMAGE_NAME):$(VERSION)
DOCKERFILE := maxscale/Dockerfile
else
LOCAL_IMAGE := $(REGISTRY)/$(IMAGE_NAME):$(VERSION)-security
DOCKERFILE := maxscale/Dockerfile.security
endif


help:
	@echo "Usage: make build [REGISTRY?=<image registry> UID?=<uid> GID?=<gid> UNAME?=<uname> GNAME?=<gname> SECURITY?=<true/false>]"
	@echo "Usage: make push [REGISTRY?=<image registry> UID?=<uid> GID?=<gid> UNAME?=<uname> GNAME?=<gname> SECURITY?=<true/false>]"
	@echo "Usage: make save [REGISTRY?=<image registry> SECURITY?=<true/false>]"

build: ## Build container image.
	@docker build -f $(DOCKERFILE) maxscale -t $(LOCAL_IMAGE) \
	  --build-arg VERSION=$(VERSION) \
	  --build-arg UID=$(UID) \
	  --build-arg GID=$(GID) \
	  --build-arg UNAME=$(UNAME) \
	  --build-arg GNAME=$(GNAME) \
	  --build-arg GIT_COMMIT=$(shell git rev-list -1 HEAD) \
	  --build-arg GIT_TREE_STATE=$(shell (git status --porcelain | grep -q .) && echo -dirty) \
	  --build-arg BUILD_TIME=$(shell date -u +%Y-%m-%d_%H:%M:%S)

push: ## Push container image.
	echo $(LOCAL_IMAGE)
	@docker push $(LOCAL_IMAGE)

save: ## Save container image
	@docker save $(LOCAL_IMAGE) -o $(IMAGE_NAME)_$(VERSION).tar