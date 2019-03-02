FROM dsio/java:8-stretch
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=spark-start \
  DAEMON_USER=spark \
  SPARK_HOME=/opt/spark \
  SPARK_DOWNLOAD=http://www-us.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz \
  HADOOP_DOWNLOAD=http://apache.cs.utah.edu/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz

RUN groupadd -r ${DAEMON_USER} --gid=999 && useradd -r -g ${DAEMON_USER} --uid=999 ${DAEMON_USER} && \
  apt-get update && \
  apt-get install -y --no-install-recommends --allow-unauthenticated curl && \
  mkdir -p ${SPARK_HOME} && \
  curl -o /tmp/spark.tar.gz -SL ${SPARK_DOWNLOAD} && \
  tar xf /tmp/spark.tar.gz -C ${SPARK_HOME} --no-same-owner --strip 1 && \
  rm /tmp/spark.tar.gz && \
  rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
  curl -o hadoop.tar.gz -SL ${HADOOP_DOWNLOAD} && \
  tar xf hadoop.tar.gz && \
  cp ./hadoop-2.7.7/share/hadoop/tools/lib/hadoop-aws-2.7.7.jar ${SPARK_HOME}/jars/ && \
  cp ./hadoop-2.7.7/share/hadoop/tools/lib/aws-java-sdk-1.7.4.jar ${SPARK_HOME}/jars/ && \
  rm -rf /tmp/hadoop-2.7.7 && \
  rm hadoop.tar.gz

ENV PATH $PATH:${SPARK_HOME}/bin

ADD root /

RUN mkdir -p ${SPARK_HOME}/work && \
  chown -R ${DAEMON_USER}:${DAEMON_USER} ${SPARK_HOME}/work
VOLUME ${SPARK_HOME}/work
WORKDIR ${SPARK_HOME}/work

EXPOSE 7077 8080
HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 8080 || exit 1

ENTRYPOINT ["docker-entrypoint.sh"]
