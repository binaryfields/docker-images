FROM alpine:3.15
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=xpostfix \
  DAEMON_USER=postfix \
  POSTFIX_VERSION=3.6.3-r1

RUN apk add --no-cache postfix=${POSTFIX_VERSION} bash rsyslog supervisor su-exec

COPY config/ /etc/

VOLUME /var/spool/postfix
WORKDIR /var/spool/postfix

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 25 465 587
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
