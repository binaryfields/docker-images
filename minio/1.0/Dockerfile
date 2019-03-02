FROM dsio/base:alpine-3.9
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=minio \
  DAEMON_USER=minio \
  MINIO_DATA_DIR=/data 

RUN addgroup -S ${DAEMON_USER} -g 999 && adduser -S -G ${DAEMON_USER} -u 999 ${DAEMON_USER} && \
  apk add --no-cache curl && \
  curl -o /usr/local/bin/minio https://dl.minio.io/server/minio/release/linux-amd64/minio && \
  chmod +x /usr/local/bin/minio && \
  apk del curl

RUN mkdir -p ${MINIO_DATA_DIR} && \
  chown -R ${DAEMON_USER}:${DAEMON_USER} ${MINIO_DATA_DIR}
VOLUME ${MINIO_DATA_DIR}
WORKDIR ${MINIO_DATA_DIR}

EXPOSE 9000
HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 9000 || exit 1

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["minio", "server", "/data"]
