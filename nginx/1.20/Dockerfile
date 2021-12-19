FROM alpine:3.15
LABEL maintainer "digitalstreamio@gmail.com"

ENV NGINX_VERSION=1.20.2-r0

RUN addgroup -S nginx -g 1000 && adduser -S -G nginx -u 1000 nginx

RUN apk add --no-cache nginx=${NGINX_VERSION} netcat-openbsd tzdata 

RUN set -ex; \
  ln -sf /dev/stdout /var/log/nginx/access.log; \
  ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
