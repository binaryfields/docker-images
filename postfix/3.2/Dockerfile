FROM dsio/base:alpine-3.7
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=xpostfix \
  DAEMON_USER=postfix \
  POSTFIX_DATA_DIR=/var/spool/postfix \
  POSTFIX_VERSION=3.2.4-r1

RUN apk add --no-cache supervisor rsyslog postfix=${POSTFIX_VERSION}

ADD root /

VOLUME ${POSTFIX_DATA_DIR}
WORKDIR ${POSTFIX_DATA_DIR}

EXPOSE 25 465 587
HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 25 || exit 1

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
