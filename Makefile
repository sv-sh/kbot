VERSION=$(shell git describe --tags)-$(shell git rev-parse --short HEAD)
APP=kbot
WINDOWS=${APP}
LINUX=${APP}
LINUX_ARM=${APP}
DARWIN=${APP}
DARWIN_AMD64=${APP}

format:
	gofmt -s -w ./

windows:
	env GOOS=windows GOARCH=amd64 go get && go build -v -o kbot -ldflags="-X="github.com/sv-sh/kbot/cmd.appVersion=${VERSION}				
linux:
	env GOOS=linux GOARCH=amd64 go get && go build -v -o kbot -ldflags="-X="github.com/sv-sh/kbot/cmd.appVersion=${VERSION}		
linux_arm:
	env GOOS=linux GOARCH=arm64 go get && go build -v -o kbot -ldflags="-X="github.com/sv-sh/kbot/cmd.appVersion=${VERSION}		
darwin:
	env GOOS=darwin GOARCH=arm64 go get && go build -v -o kbot -ldflags="-X="github.com/sv-sh/kbot/cmd.appVersion=${VERSION}
darwin_amd64:
	env GOOS=darwin GOARCH=amd64 go get && go build -v -o kbot -ldflags="-X="github.com/sv-sh/kbot/cmd.appVersion=${VERSION}
image:
	docker build -t ${APP}/${VERSION} --build-arg TARGETOS=linux .
clean:
	docker rmi ${APP}/${VERSION}