VERSION 								:= $(shell cat version.txt)
APP_NAME                = $(shell pwd | sed 's:.*/::')
GIT_HASH                = $(shell git rev-parse HEAD)
DOCKER                  := docker
DOCKER_IMAGE            := ericsperano/$(APP_NAME):$(VERSION)
DOCKER_IMAGE_LATEST     := ericsperano/$(APP_NAME):latest

.DEFAULT_GOAL = image

image:
	$(DOCKER) build -t $(DOCKER_IMAGE) . #--squash
	$(DOCKER) tag $(DOCKER_IMAGE) $(DOCKER_IMAGE_LATEST)

push:
	$(DOCKER) push $(DOCKER_IMAGE)
	$(DOCKER) push $(DOCKER_IMAGE_LATEST)

run: image
	$(DOCKER) run --rm -p 5555:80 $(DOCKER_IMAGE)
