FROM dsio/base:alpine-3.10
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=memcached \
	MEMCACHED_VERSION=1.5.16-r0

RUN addgroup -S memcached -g 999 && adduser -S -G memcached -u 999 memcached && \
	apk add --no-cache memcached=${MEMCACHED_VERSION}

EXPOSE 11211
HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 11211 || exit 1

USER memcached
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["memcached"]
