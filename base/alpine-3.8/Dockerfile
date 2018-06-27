FROM alpine:3.7
LABEL maintainer "digitalstreamio@gmail.com"

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main' > /etc/apk/repositories && \
	echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/community' >> /etc/apk/repositories && \
	apk upgrade -U -a

RUN apk add --no-cache netcat-openbsd su-exec && \
	delgroup ping

ADD confd-*.go /tmp

RUN apk add --no-cache --virtual .build-deps git make musl-dev go && \
	export GOPATH=/go && \
	mkdir -p $GOPATH/src/github.com/kelseyhightower && \
	git clone https://github.com/kelseyhightower/confd.git $GOPATH/src/github.com/kelseyhightower/confd && \
	cd $GOPATH/src/github.com/kelseyhightower/confd && \
	git checkout v0.16.0 && \
	cd $GOPATH/src/github.com/kelseyhightower/confd && \
	cp /tmp/confd-backends-client.go backends/client.go && \
	go build -ldflags "-s -w" -o bin/confd . && \
	cp bin/confd /usr/local/bin/ && \
	rm -rf /go && \
	rm -rf /tmp/confd-*.go && \
	apk del .build-deps && \
	mkdir -p /etc/confd/conf.d /etc/confd/templates

ADD root /
