#!/bin/sh
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- ${DAEMON} "$@"
fi

if [ "$1" = "${DAEMON}" -a "$(id -u)" = "0" ]; then
	find . \! -user ${DAEMON_USER} -exec chown ${DAEMON_USER} '{}' +
	exec su-exec ${DAEMON_USER} "$@"
fi

exec "$@"
