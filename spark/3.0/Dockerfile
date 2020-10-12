FROM openjdk:8-alpine
LABEL maintainer "digitalstreamio@gmail.com"

RUN delgroup ping && addgroup -S spark -g 999 && adduser -S -G spark -u 999 spark 

ENV SPARK_HOME=/opt/spark \
  SPARK_LOCAL_DIRS=/data/tmp \
  SPARK_LOG_DIR=/data/logs \
  SPARK_WORKER_DIR=/data/work \
  SPARK_DOWNLOAD=http://www-us.apache.org/dist/spark/spark-3.0.1/spark-3.0.1-bin-hadoop2.7.tgz \
  HADOOP_DOWNLOAD=http://apache.cs.utah.edu/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz

RUN set -ex; \
  apk add --no-cache bash tini libc6-compat linux-pam nss netcat-openbsd su-exec tzdata; \
  rm /bin/sh; \
  ln -sv /bin/bash /bin/sh; \
  echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su; \
  chgrp root /etc/passwd && chmod ug+rw /etc/passwd

RUN set -ex; \
  apk add --no-cache curl; \
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
  apk del curl

ENV PATH $PATH:${SPARK_HOME}/bin

RUN mkdir -p /data && chown spark -R /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
