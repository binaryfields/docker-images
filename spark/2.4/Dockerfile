FROM openjdk:8-jre-slim
LABEL maintainer "digitalstreamio@gmail.com"

RUN groupadd -r spark --gid=999 && useradd -r -g spark --uid=999 spark

ENV DAEMON=spark-start \
  DAEMON_USER=spark \
  SPARK_HOME=/opt/spark \
  SPARK_DOWNLOAD=http://www-us.apache.org/dist/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz \
  HADOOP_DOWNLOAD=http://apache.cs.utah.edu/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz

RUN set -ex; \
  apt-get update; \
  apt-get install -y --no-install-recommends --allow-unauthenticated curl netcat; \
  curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64"; \
  chmod +x /usr/local/bin/gosu; \
  rm -rf /var/lib/apt/lists/*

RUN set -ex; \
  apt-get update; \
  apt-get install -y --no-install-recommends --allow-unauthenticated curl; \
  mkdir -p ${SPARK_HOME}; \
  curl -o /tmp/spark.tar.gz -SL ${SPARK_DOWNLOAD}; \
  tar xf /tmp/spark.tar.gz -C ${SPARK_HOME} --no-same-owner --strip 1; \
  rm /tmp/spark.tar.gz; \
  cd /tmp; \
  curl -o hadoop.tar.gz -SL ${HADOOP_DOWNLOAD}; \
  tar xf hadoop.tar.gz; \
  rm hadoop.tar.gz; \
  cp ./hadoop-2.7.7/share/hadoop/tools/lib/hadoop-aws-2.7.7.jar ${SPARK_HOME}/jars/; \
  cp ./hadoop-2.7.7/share/hadoop/tools/lib/aws-java-sdk-1.7.4.jar ${SPARK_HOME}/jars/; \
  rm -rf /tmp/hadoop-2.7.7; \
  rm -rf /var/lib/apt/lists/*

COPY spark-start /usr/local/bin/

ENV PATH $PATH:${SPARK_HOME}/bin

RUN mkdir -p /opt/spark/work && chown -R spark:spark /opt/spark/work
VOLUME /opt/spark/work
WORKDIR /opt/spark/work

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 8080 || exit 1

EXPOSE 7077 8080
ENTRYPOINT ["docker-entrypoint.sh"]
