FROM alpine:3.12
LABEL maintainer "digitalstreamio@gmail.com"

RUN delgroup ping && addgroup -S nginx -g 999 && adduser -S -G nginx -u 999 nginx 

ENV NGINX_VERSION=1.18.0-r0

RUN apk add --no-cache nginx=${NGINX_VERSION} netcat-openbsd tzdata 

RUN set -ex; \
  ln -sf /dev/stdout /var/log/nginx/access.log; \
  ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
