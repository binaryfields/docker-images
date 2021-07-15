#!/usr/bin/env bash
set -e

for yaml in \
	mydestination \
	myhostname \
	myorigin \
	relayhost \
; do
	var="POSTFIX_${yaml^^}"
	val="${!var}"
	if [ "$val" ]; then
		sed -ri 's/^(# )?('"$yaml"')\s*=.*/\2 = '"$val"'/' "/etc/postfix/main.cf"
	fi
done

if [ "${1:0:1}" = '-' ]; then
    set -- ${DAEMON} "$@"
fi

if [ "$1" = "${DAEMON}" -a "$(id -u)" = "0" ]; then
	find . \! -user ${DAEMON_USER} -exec chown ${DAEMON_USER} '{}' +
	exec su-exec ${DAEMON_USER} "$@"
fi

exec "$@"
