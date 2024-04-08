.PHONY: linux arm macos windows clean

APP_NAME := myapp
REGISTRY := myregistry
IMAGE_TAG := $(REGISTRY)/$(APP_NAME)

linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o $(APP_NAME)-linux-amd64 .

arm:
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o $(APP_NAME)-linux-arm64 .

macos:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o $(APP_NAME)-macos-amd64 .

windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o $(APP_NAME)-windows-amd64.exe .

clean:
	rm -f $(APP_NAME)-*
	docker rmi $(IMAGE_TAG)
