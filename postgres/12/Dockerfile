FROM alpine:3.12
LABEL maintainer "digitalstreamio@gmail.com"

# alpine includes "postgres" user/group in base install

ENV DAEMON=postgres \
  DAEMON_USER=postgres \
  LANG=en_US.utf8 \
  PGDATA=/var/lib/postgresql/data \
  PG_MAJOR=12.4 \
  PG_VERSION=12.4-r0

RUN apk add --no-cache bash netcat-openbsd su-exec tzdata 

RUN set -ex; \
  apk add --no-cache postgresql=${PG_VERSION} postgresql-contrib=${PG_VERSION}; \
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
