FROM alpine:3.10
LABEL maintainer "digitalstreamio@gmail.com"

RUN delgroup ping && addgroup -S minio -g 999 && adduser -S -G minio -u 999 minio 

ENV DAEMON=minio \
  DAEMON_USER=minio

RUN apk add --no-cache netcat-openbsd su-exec 

RUN set -ex; \
  apk add --no-cache curl; \
  curl -o /usr/local/bin/minio https://dl.minio.io/server/minio/release/linux-amd64/minio; \
  chmod +x /usr/local/bin/minio; \
  apk del curl

RUN mkdir -p /data && chown -R minio:minio /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 9000 || exit 1

EXPOSE 9000
CMD ["minio", "server", "/data"]
