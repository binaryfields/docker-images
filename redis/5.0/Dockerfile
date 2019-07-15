FROM alpine:3.10
LABEL maintainer "digitalstreamio@gmail.com"

RUN delgroup ping && addgroup -S redis -g 999 && adduser -S -G redis -u 999 redis 

ENV DAEMON=redis-server \
  DAEMON_USER=redis \
  REDIS_VERSION=5.0.5-r0

RUN apk add --no-cache netcat-openbsd su-exec tzdata 

RUN apk add --no-cache redis=${REDIS_VERSION}

COPY redis.conf /etc/

RUN mkdir -p /data && chown -R redis:redis /data && chown redis:root /etc/redis.conf
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server", "/etc/redis.conf"]
