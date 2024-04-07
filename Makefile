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

linux: ## Build for Linux
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o my-binary-linux .

arm: ## Build for ARM
	CGO_ENABLED=0 GOOS=linux GOARCH=arm go build -o my-binary-arm .

macos: ## Build for macOS
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o my-binary-macos .

windows: ## Build for Windows
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o my-binary-windows.exe .

build: format get
	@for os in $(TARGETOS); do \
		for arch in $(TARGETARCH); do \
			CGO_ENABLED=0 GOOS=$$os GOARCH=$$arch go build -v -o kbot-$$os-$$arch -ldflags "-X=github.com/HetmanRuslan/kbot/cmd.appVersion=$(VERSION)"; \
		done \
	done

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot-*
