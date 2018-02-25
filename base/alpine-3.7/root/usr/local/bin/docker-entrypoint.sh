#!/bin/sh

set -e -o pipefail

HOST_IPV4="$(hostname -i)"
export HOST_IPV4
echo "Host IP: ${HOST_IPV4}"

if [ -n "${WAIT_FOR_SERVICE}" ]; then
	SERVICE_IPS=""
	while [ -z "${SERVICE_IPS}" ]; do
			echo "Waiting for ${WAIT_FOR_SERVICE} ..."
	    sleep 5
	    SERVICE_IPS=$(getent hosts "${WAIT_FOR_SERVICE}" || echo "")
	done
fi 

echo "Running confd ..."
confd -onetime -backend env

if [ "${1:0:1}" = '-' ]; then
  set -- ${DAEMON} "$@"
fi

if [ "$1" = "${DAEMON}" -a "$(id -u)" = "0" ]; then
  echo "Running chown $(pwd) ..."
	chown -R ${DAEMON_USER} .
	set -- su-exec ${DAEMON_USER} "$@"
fi

echo "Launching: $@"
exec "$@"
