FROM alpine:3.15
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=memcached \
	MEMCACHED_VERSION=1.6.12-r0

RUN delgroup ping && addgroup -S memcache -g 999 && adduser -S -G memcache -u 999 memcache 

RUN apk add --no-cache memcached=${MEMCACHED_VERSION} 

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

USER memcache
EXPOSE 11211
CMD ["memcached"]
