FROM debian:stretch-slim
LABEL maintainer "digitalstreamio@gmail.com"

RUN apt-get update && \
  apt-get install -y --no-install-recommends ca-certificates curl netcat && \
  curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64" && \
  chmod +x /usr/local/bin/gosu && \
	mkdir -p /etc/confd/conf.d /etc/confd/templates && \
	mkdir /usr/share/man/man1 && \  
  apt-get purge -y --auto-remove curl && \
  rm -rf /var/lib/apt/lists/* 

ADD root /
