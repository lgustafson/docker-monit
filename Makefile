NAME = lgustafson/docker-monit
VERSION = 0.4.1

.PHONY: all build tag_latest

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm image

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest
