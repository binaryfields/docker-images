FROM dsio/java:8-stretch
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=cassandra \
  DAEMON_USER=cassandra \
  CASSANDRA_CONF=/etc/cassandra \
  CASSANDRA_DATA_DIR=/var/lib/cassandra \
  CASSANDRA_HOME=/opt/cassandra \
  CASSANDRA_DOWNLOAD=http://apache.mirrors.hoobly.com/cassandra/3.11.3/apache-cassandra-3.11.3-bin.tar.gz

RUN groupadd -r ${DAEMON_USER} --gid=999 && useradd -r -g ${DAEMON_USER} --uid=999 ${DAEMON_USER} && \
  apt-get update && \
  apt-get install -y --no-install-recommends curl libjemalloc1 libjna-java python && \
  mkdir -p ${CASSANDRA_HOME} && \
  curl -o /tmp/cassandra.tar.gz -SL ${CASSANDRA_DOWNLOAD} && \
  tar xf /tmp/cassandra.tar.gz -C ${CASSANDRA_HOME} --no-same-owner --strip 1 && \
  rm /tmp/cassandra.tar.gz && \
  ln -s /usr/share/java/jna.jar ${CASSANDRA_HOME}/lib/jna.jar && \
  rm -r ${CASSANDRA_HOME}/javadoc && \
  apt-get purge -y --auto-remove curl && \
  rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:${CASSANDRA_HOME}/bin

ADD root /

RUN mkdir -p ${CASSANDRA_CONF} && \
  cp ${CASSANDRA_HOME}/conf/* ${CASSANDRA_CONF} | true && \
  mkdir -p ${CASSANDRA_DATA_DIR} && \
  chown -R ${DAEMON_USER}:${DAEMON_USER} ${CASSANDRA_DATA_DIR}
VOLUME ${CASSANDRA_DATA_DIR}
WORKDIR ${CASSANDRA_DATA_DIR}

EXPOSE 7000 9042

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["cassandra", "-f"]

#HEALTHCHECK --interval=30s --timeout=10s \
#  CMD nc -z -v -w5 localhost 9042 || exit 1
