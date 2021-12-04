FROM alpine:3.15
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=minio \
  DAEMON_USER=minio

RUN delgroup ping && addgroup -S minio -g 999 && adduser -S -G minio -u 999 minio 

RUN set -ex; \
  apk add --no-cache curl su-exec; \
  curl -o /usr/local/bin/minio https://dl.minio.io/server/minio/release/linux-amd64/minio; \
  chmod +x /usr/local/bin/minio; \
  apk del curl

RUN mkdir -p /data && chown -R minio:minio /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 9000
CMD ["minio", "server", "/data"]
