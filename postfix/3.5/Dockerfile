FROM alpine:3.13
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=xpostfix \
  DAEMON_USER=postfix \
  POSTFIX_VERSION=3.5.9-r0

RUN apk add --no-cache bash netcat-openbsd rsyslog supervisor su-exec

RUN apk add --no-cache postfix=${POSTFIX_VERSION}

COPY config/ /etc/

VOLUME /var/spool/postfix
WORKDIR /var/spool/postfix

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 25 465 587
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
