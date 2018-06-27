FROM dsio/base:alpine-3.8
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=memcached \
	MEMCACHED_VERSION=1.5.8-r0

RUN addgroup -S memcache -g 999 && adduser -S -G memcache -u 999 memcache && \
	apk add --no-cache memcached=${MEMCACHED_VERSION}

EXPOSE 11211
HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 11211 || exit 1

USER memcache
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["memcached"]
