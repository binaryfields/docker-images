FROM alpine:3.10
LABEL maintainer "digitalstreamio@gmail.com"

RUN delgroup ping && addgroup -S memcache -g 999 && adduser -S -G memcache -u 999 memcache 

ENV DAEMON=memcached \
	MEMCACHED_VERSION=1.5.16-r0

RUN apk add --no-cache netcat-openbsd;

RUN apk add --no-cache memcached=${MEMCACHED_VERSION} 

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

USER memcache
EXPOSE 11211
CMD ["memcached"]
