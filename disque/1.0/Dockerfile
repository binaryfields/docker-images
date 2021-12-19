FROM alpine:3.15
LABEL maintainer "digitalstreamio@gmail.com"

RUN addgroup -S disque -g 1000 && adduser -S -G disque -u 1000 disque

ENV DAEMON=disque-server \
  DAEMON_USER=disque

RUN apk add --no-cache netcat-openbsd su-exec tzdata

RUN set -ex; \
  apk add --no-cache build-base git linux-headers; \
  git clone https://github.com/antirez/disque; \
  cd disque; \
  sed -i 's/#if defined(__APPLE__) || defined(__linux__).*/#if defined(__APPLE__) || (defined(__linux__) \&\& defined(__GLIBC__))/' src/config.h; \
  sed -i 's/#if (defined __linux || defined __APPLE__).*/#if ((defined __linux \&\& defined(__GLIBC__)) || defined __APPLE__)/' src/config.h; \
  make all; \
  strip src/disque src/disque-check-aof src/disque-server; \
  make install; \
  cd ..; \
  rm -r disque; \
  apk del build-base git linux-headers

COPY disque.conf /etc/

RUN mkdir -p /data && chown -R disque:disque /data && chown disque:root /etc/disque.conf
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 7711
CMD ["disque-server", "/etc/disque.conf"]
