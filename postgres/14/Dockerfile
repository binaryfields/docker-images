FROM alpine:3.15
LABEL maintainer "digitalstreamio@gmail.com"

# alpine includes "postgres" user/group in base install

ENV DAEMON=postgres \
  DAEMON_USER=postgres \
  LANG=en_US.utf8 \
  PGDATA=/var/lib/postgresql/data \
  PG_MAJOR=14.1 \
  PG_VERSION=14.1-r4

RUN set -ex; \
  apk add --no-cache postgresql14=${PG_VERSION} postgresql14-contrib=${PG_VERSION} bash su-exec tzdata; \
  sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /usr/share/postgresql/postgresql.conf.sample

ENV PATH $PATH:/usr/lib/postgresql/$PG_MAJOR/bin

RUN mkdir -p /var/run/postgresql && chown -R postgres:postgres /var/run/postgresql && \
  chmod g+s /var/run/postgresql
  
RUN mkdir -p /var/lib/postgresql/data && chown -R postgres:postgres /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data
WORKDIR /var/lib/postgresql/data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
