FROM dsio/base:alpine-3.8
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=postgres \
  DAEMON_USER=postgres \
  LANG=en_US.utf8 \
  PGDATA=/var/lib/postgresql/data \
  PG_MAJOR=10.4 \
  PG_VERSION=10.4-r0

# addgroup -S ${DAEMON_USER} -g 999 && adduser -S -G ${DAEMON_USER} -u 999 ${DAEMON_USER} && \

RUN apk add --no-cache postgresql=${PG_VERSION} postgresql-contrib=${PG_VERSION} && \
  apk add --no-cache bash tzdata && \
  sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /usr/share/postgresql/postgresql.conf.sample

ENV PATH $PATH:/usr/lib/postgresql/$PG_MAJOR/bin

ADD root /

RUN mkdir -p /var/run/postgresql && \
  chown -R  ${DAEMON_USER}:${DAEMON_USER} /var/run/postgresql && \
  chmod g+s /var/run/postgresql && \
  mkdir -p ${PGDATA} && \
  chown -R ${DAEMON_USER}:${DAEMON_USER} ${PGDATA}
VOLUME ${PGDATA}
WORKDIR ${PGDATA}

EXPOSE 5432
HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 5432 || exit 1

ENTRYPOINT ["/entrypoint-postgres.sh"]
CMD ["postgres"]
