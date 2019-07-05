FROM alpine:3.10
LABEL maintainer "digitalstreamio@gmail.com"

RUN delgroup ping && addgroup -S nginx -g 999 && adduser -S -G nginx -u 999 nginx 

ENV NGINX_VERSION=1.16.0-r2

RUN apk add --no-cache nginx=${NGINX_VERSION} netcat-openbsd tzdata 

RUN set -ex; \
  ln -sf /dev/stdout /var/log/nginx/access.log; \
  ln -sf /dev/stderr /var/log/nginx/error.log

HEALTHCHECK --interval=30s --timeout=10s \
  CMD nc -z -v -w5 localhost 80 || exit 1

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
