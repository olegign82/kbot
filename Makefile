APP=${shell basename $(shell git remote get-url origin)}
REGISTRY=ghcr.io/olegign82
#REGISTRY=gcr.io/causal-cubist-428122-k3
#REGISTRY=olegign82
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux#windows linux darwin
TARGETARCH=amd64#amd64 arm64 x86_64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get: go get

build: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/olegign82/kbot/cmd.appVersion=${VERSION}

linux: format
	CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/olegign82/kbot/cmd.appVersion=${VERSION}

windows: format
	CGO_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/olegign82/kbot/cmd.appVersion=${VERSION}

macos: format
	CGO_ENABLED=0 GOOS=darwin GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/olegign82/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}