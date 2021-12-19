FROM openjdk:8-jre-slim
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=elasticsearch \
  DAEMON_USER=elasticsearch \
  ES_HOME=/opt/elasticsearch \
  ES_PATH_CONF=/opt/elasticsearch/config \
  ES_DOWNLOAD=https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.7.1.tar.gz

RUN groupadd -r elasticsearch --gid=1000 && useradd -r -g elasticsearch --uid=1000 elasticsearch

RUN set -ex; \
  apt-get update; \
  apt-get install -y --no-install-recommends --allow-unauthenticated curl; \
  curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64"; \
  chmod +x /usr/local/bin/gosu; \
  apt-get purge -y --auto-remove curl; \
  rm -rf /var/lib/apt/lists/*

RUN set -ex; \
  apt-get update; \
  apt-get install -y --no-install-recommends --allow-unauthenticated curl; \
  mkdir -p ${ES_HOME}; \
  curl -o /tmp/elasticsearch.tar.gz -SL ${ES_DOWNLOAD}; \
  tar xf /tmp/elasticsearch.tar.gz -C ${ES_HOME} --no-same-owner --strip 1; \
  rm /tmp/elasticsearch.tar.gz; \
  apt-get purge -y --auto-remove curl; \
  rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:${ES_HOME}/bin

COPY config/elasticsearch.yml config/log4j2.properties ${ES_HOME}/config/

RUN chown -R elasticsearch:root ${ES_PATH_CONF} && \
  chmod g+s ${ES_PATH_CONF} && \
  chmod 0750 ${ES_PATH_CONF}

RUN ${ES_HOME}/bin/elasticsearch-keystore create && \
  chown elasticsearch:root ${ES_PATH_CONF}/elasticsearch.keystore && \
  chmod 660 ${ES_PATH_CONF}/elasticsearch.keystore && \
  md5sum ${ES_PATH_CONF}/elasticsearch.keystore > ${ES_PATH_CONF}/.elasticsearch.keystore.initial_md5sum

RUN mkdir -p /var/lib/elasticsearch && chown -R elasticsearch:elasticsearch /var/lib/elasticsearch && \
  mkdir -p /var/log/elasticsearch && chown -R elasticsearch:elasticsearch /var/log/elasticsearch
VOLUME /var/lib/elasticsearch
WORKDIR /var/lib/elasticsearch

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 9200 9300
CMD ["elasticsearch"]
