APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=hetmanruslan10
VERSION := $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS = linux darwin
TARGETARCH = amd64 arm64

format:
	gofmt -s -w ./

lint:
	golint ./...

test:
	go test -v ./...

get:
	go get

linux: ## Build for Linux
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o my-binary-linux .

arm: ## Build for ARM
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o my-binary-arm .

macos: ## Build for macOS
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o my-binary-macos .

windows: ## Build for Windows
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o my-binary-windows.exe .

build: format get
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o kbot -ldflags "-X=github.com/HetmanRuslan/kbot/cmd.appVersion=$(VERSION)"

image:
	docker buildx build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
