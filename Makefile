APP=${shell basename $(shell git remote get-url origin)}
REGISTRY=olegign82
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
#VERSION=v1.0.5-$(shell git rev-parse --short HEAD)
TARGETOS=linux #windows
TARGETARCH=amd64 #amd64 arm64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get: go get

build: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/olegign82/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot
	rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}