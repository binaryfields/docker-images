FROM alpine:3.15
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=redis-server \
  DAEMON_USER=redis \
  REDIS_VERSION=6.2.6-r0

RUN addgroup -S redis -g 1000 && adduser -S -G redis -u 1000 redis 

RUN apk add --no-cache redis=${REDIS_VERSION} su-exec tzdata

COPY redis.conf /etc/

RUN mkdir -p /data && chown -R redis:redis /data && chown redis:root /etc/redis.conf
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server", "/etc/redis.conf"]
