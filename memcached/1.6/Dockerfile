FROM alpine:3.15
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=memcached \
	MEMCACHED_VERSION=1.6.12-r0

RUN addgroup -S memcache -g 1000 && adduser -S -G memcache -u 1000 memcache 

RUN apk add --no-cache memcached=${MEMCACHED_VERSION} 

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

USER memcache
EXPOSE 11211
CMD ["memcached"]
