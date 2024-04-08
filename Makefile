APP := $(shell basename $(shell git remote get-url origin))
REGISTRY := hetmanruslan10
GIT_DESCRIBE := $(shell git describe --tags --abbrev=0)
GIT_COMMIT := $(shell git rev-parse --short HEAD)
VERSION := $(if $(GIT_DESCRIBE),$(GIT_DESCRIBE),v1.0.0)-$(GIT_COMMIT)
TARGETARCH := arm64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=linux GOARCH=$(TARGETARCH) go build -v -o kbot -ldflags "-X github.com/HetmanRuslan/kbot/cmd.appVersion=$(VERSION)"

image:
	docker build . -t $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH) --build-arg TARGETARCH=$(TARGETARCH)

push:
	docker push $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH)

clean:
	rm -rf kbot
	docker rmi $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH)
