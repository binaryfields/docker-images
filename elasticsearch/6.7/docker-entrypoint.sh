#!/usr/bin/env bash
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- ${DAEMON} "$@"
fi

if [ "$1" = "${DAEMON}" -a "$(id -u)" = "0" ]; then
	find . \! -user ${DAEMON_USER} -exec chown ${DAEMON_USER} '{}' +
	exec gosu ${DAEMON_USER} "$@"
fi

exec "$@"
