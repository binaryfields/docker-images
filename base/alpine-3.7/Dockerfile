FROM alpine:3.7
LABEL maintainer "digitalstreamio@gmail.com"

RUN apk add --no-cache netcat-openbsd su-exec && \
	delgroup ping && \
	mkdir -p /etc/confd/conf.d /etc/confd/templates 

ADD root /
