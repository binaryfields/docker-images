FROM dsio/base:alpine-3.10
LABEL maintainer "digitalstreamio@gmail.com"

ENV DAEMON=xnginx \
  NGINX_LOG_DIR=/var/log/nginx \
  NGINX_VERSION=1.16.0-r2

RUN addgroup -S nginx -g 999 && adduser -S -G nginx -u 999 nginx && \
  apk add --no-cache nginx=${NGINX_VERSION} && \
  ln -sf /dev/stderr ${NGINX_LOG_DIR}/error.log

ADD root /

VOLUME ${NGINX_LOG_DIR}
WORKDIR ${NGINX_LOG_DIR}

EXPOSE 80 443
HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 80 || exit 1

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
