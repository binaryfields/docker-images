FROM dsio/base:alpine-3.7
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=disque-server \
  DAEMON_USER=disque \
  DISQUE_DATA_DIR=/var/lib/disque

RUN addgroup -S ${DAEMON_USER} -g 999 && adduser -S -G ${DAEMON_USER} -u 999 ${DAEMON_USER} && \
  apk add --no-cache build-base git linux-headers && \
  git clone https://github.com/antirez/disque && \
  cd disque && \
  sed -i 's/#if defined(__APPLE__) || defined(__linux__).*/#if defined(__APPLE__) || (defined(__linux__) \&\& defined(__GLIBC__))/' src/config.h && \
  sed -i 's/#if (defined __linux || defined __APPLE__).*/#if ((defined __linux \&\& defined(__GLIBC__)) || defined __APPLE__)/' src/config.h && \
  make all && \
  strip src/disque src/disque-check-aof src/disque-server && \
  make install && \
  cd .. && \
  rm -r disque && \
  apk del build-base git linux-headers

ADD root /

RUN mkdir -p ${DISQUE_DATA_DIR} && \
  chown -R ${DAEMON_USER}:${DAEMON_USER} ${DISQUE_DATA_DIR}
VOLUME ${DISQUE_DATA_DIR}
WORKDIR ${DISQUE_DATA_DIR}

EXPOSE 7711
HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 7711 || exit 1

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["disque-server", "/etc/disque.conf"]
