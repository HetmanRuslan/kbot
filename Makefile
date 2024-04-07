APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=hetmanruslan10
VERSION := $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS = linux darwin
TARGETARCH = amd64 arm

format:
	gofmt -s -w ./

lint:
	golint ./...

test:
	go test -v ./...

get:
	go get

build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o kbot-linux-amd64 -ldflags "-X=github.com/HetmanRuslan/kbot/cmd.appVersion=$(VERSION)"

build-arm:
	CGO_ENABLED=0 GOOS=linux GOARCH=arm go build -v -o kbot-linux-arm -ldflags "-X=github.com/HetmanRuslan/kbot/cmd.appVersion=$(VERSION)"

build-macos:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o kbot-macos-amd64 -ldflags "-X=github.com/HetmanRuslan/kbot/cmd.appVersion=$(VERSION)"

build-windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o kbot-windows-amd64.exe -ldflags "-X=github.com/HetmanRuslan/kbot/cmd.appVersion=$(VERSION)"


build: format get
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o kbot -ldflags "-X=github.com/HetmanRuslan/kbot/cmd.appVersion=$(VERSION)"

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot
