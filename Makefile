APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=hetmanruslan10
VERSION := $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETARCH = amd64 arm

format:
    gofmt -s -w ./

lint:
    golint ./...

test:
    go test -v ./...

get:
    go get

linux: ## Build for Linux
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o kbot-linux-amd64 .

arm: ## Build for ARM
    CGO_ENABLED=0 GOOS=linux GOARCH=arm go build -o kbot-linux-arm .

macos: ## Build for macOS
    CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o kbot-macos-amd64 .

windows: ## Build for Windows
    CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o kbot-windows-amd64.exe .

build: format get
    go build -v -o kbot -ldflags "-X=github.com/HetmanRuslan/kbot/cmd.appVersion=$(VERSION)"

image:
    docker buildx build --platform $(TARGETARCH) . -t ${REGISTRY}/${APP}:${VERSION} --push

push:
    docker push ${REGISTRY}/${APP}:${VERSION}

clean:
    rm -rf kbot kbot-*
