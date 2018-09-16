FROM dsio/base:alpine-3.8
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=redis-server \
  DAEMON_USER=redis \
  REDIS_DATA_DIR=/var/lib/redis \
  REDIS_VERSION=4.0.11-r0

RUN addgroup -S ${DAEMON_USER} -g 999 && adduser -S -G ${DAEMON_USER} -u 999 ${DAEMON_USER} && \
  apk add --no-cache redis=${REDIS_VERSION}

ADD root /

RUN mkdir -p ${REDIS_DATA_DIR} && \
  chown -R ${DAEMON_USER}:${DAEMON_USER} ${REDIS_DATA_DIR}
VOLUME ${REDIS_DATA_DIR}
WORKDIR ${REDIS_DATA_DIR}

EXPOSE 6379
HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 6379 || exit 1

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["redis-server", "/etc/redis.conf"]
