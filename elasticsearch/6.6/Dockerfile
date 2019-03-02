FROM dsio/java:8-stretch
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=elasticsearch \
  DAEMON_USER=elasticsearch \
  ES_DATA_DIR=/var/lib/elasticsearch \
  ES_HOME=/opt/elasticsearch \
  ES_LOG_DIR=/var/log/elasticsearch \
  ES_PATH_CONF=/etc/elasticsearch \
  ES_DOWNLOAD=https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.6.1.tar.gz

RUN groupadd -r ${DAEMON_USER} --gid=999 && useradd -r -g ${DAEMON_USER} --uid=999 ${DAEMON_USER} && \
  apt-get update && \
  apt-get install -y --no-install-recommends --allow-unauthenticated curl && \
  mkdir -p ${ES_HOME} && \
  curl -o /tmp/elasticsearch.tar.gz -SL ${ES_DOWNLOAD} && \
  tar xf /tmp/elasticsearch.tar.gz -C ${ES_HOME} --no-same-owner --strip 1 && \
  rm /tmp/elasticsearch.tar.gz && \
  apt-get purge -y --auto-remove curl && \
  rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:${ES_HOME}/bin

ADD root /

RUN chown -R root:${DAEMON_USER} ${ES_PATH_CONF} && \
  chmod g+s ${ES_PATH_CONF} && \
  chmod 0750 ${ES_PATH_CONF} && \
  mkdir -p ${ES_DATA_DIR} && \
  chown ${DAEMON_USER}:${DAEMON_USER} ${ES_DATA_DIR} && \
  mkdir -p ${ES_LOG_DIR} && \
  chown -R ${DAEMON_USER}:${DAEMON_USER} ${ES_LOG_DIR}

RUN ${ES_HOME}/bin/elasticsearch-keystore create && \
  chown root:${DAEMON_USER} ${ES_PATH_CONF}/elasticsearch.keystore && \
  chmod 660 ${ES_PATH_CONF}/elasticsearch.keystore && \
  md5sum ${ES_PATH_CONF}/elasticsearch.keystore > ${ES_PATH_CONF}/.elasticsearch.keystore.initial_md5sum

VOLUME ${ES_DATA_DIR}
WORKDIR ${ES_DATA_DIR}

EXPOSE 9200 9300

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["elasticsearch"]

#HEALTHCHECK --interval=30s --timeout=10s \
#  CMD nc -z -v -w5 localhost 9300 || exit 1
