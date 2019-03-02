FROM dsio/base:stretch
LABEL maintainer "digitalstreamio@gmail.com"

RUN apt-get update && \
  apt-get install -y --allow-unauthenticated --no-install-recommends \
    openjdk-8-jre-headless libjemalloc1 libjna-java && \
  rm -rf /var/lib/apt/lists/*
