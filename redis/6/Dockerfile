FROM alpine:3.14
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=redis-server \
  DAEMON_USER=redis \
  REDIS_VERSION=6.2.4-r0

RUN delgroup ping && addgroup -S redis -g 999 && adduser -S -G redis -u 999 redis 

RUN apk add --no-cache redis=${REDIS_VERSION} su-exec tzdata

COPY redis.conf /etc/

RUN mkdir -p /data && chown -R redis:redis /data && chown redis:root /etc/redis.conf
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server", "/etc/redis.conf"]
