FROM openjdk:8-jre-slim-stretch
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=cassandra \
  DAEMON_USER=cassandra \
  CASSANDRA_CONF=/opt/cassandra/conf \
  CASSANDRA_HOME=/opt/cassandra \
  CASSANDRA_DOWNLOAD=https://downloads.apache.org/cassandra/3.11.11/apache-cassandra-3.11.11-bin.tar.gz

RUN groupadd -r cassandra --gid=1000 && useradd -r -g cassandra --uid=1000 cassandra 

RUN set -ex; \
  apt-get update; \
  apt-get install -y --no-install-recommends --allow-unauthenticated \
    curl iproute2 procps python libjemalloc1 libjna-java; \
  curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64"; \
  chmod +x /usr/local/bin/gosu; \
  apt-get purge -y --auto-remove curl; \
  rm -rf /var/lib/apt/lists/*

RUN set -ex; \
  apt-get update; \
  apt-get install -y --no-install-recommends --allow-unauthenticated curl; \
  mkdir -p ${CASSANDRA_HOME}; \
  curl -o /tmp/cassandra.tar.gz -SL ${CASSANDRA_DOWNLOAD}; \
  tar xf /tmp/cassandra.tar.gz -C ${CASSANDRA_HOME} --no-same-owner --strip 1; \
  rm /tmp/cassandra.tar.gz; \
  ln -s /usr/share/java/jna.jar ${CASSANDRA_HOME}/lib/jna.jar; \
  apt-get purge -y --auto-remove curl; \
  rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:${CASSANDRA_HOME}/bin

COPY config/logback.xml ${CASSANDRA_HOME}/conf/

RUN set -ex; \
  sed -ri "s!^(# )?(data_file_directories:).*!\2 [ /data/data ]!" ${CASSANDRA_CONF}/cassandra.yaml; \
  sed -ri "s!^(# )?(commitlog_directory:).*!\2 /data/commitlog!" ${CASSANDRA_CONF}/cassandra.yaml; \
  sed -ri "s!^(# )?(hints_directory:).*!\2 /data/hints_directory!" ${CASSANDRA_CONF}/cassandra.yaml; \
  sed -ri "s!^(# )?(saved_caches_directory:).*!\2 /data/saved_caches!" ${CASSANDRA_CONF}/cassandra.yaml

RUN mkdir -p /data && chown -R cassandra:cassandra /data 
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 7000 9042
CMD ["cassandra", "-f"]
