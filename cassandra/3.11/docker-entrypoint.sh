#!/usr/bin/env bash
set -e

_ip_address() {
	# scrape the first non-localhost IP address of the container
	# in Swarm Mode, we often get two IPs -- the container IP, and the (shared) VIP, and the container IP should always be first
	ip address | awk '
		$1 == "inet" && $NF != "lo" {
			gsub(/\/.+$/, "", $2)
			print $2
			exit
		}
	'
}

: ${CASSANDRA_RPC_ADDRESS='0.0.0.0'}
: ${CASSANDRA_LISTEN_ADDRESS='auto'}
if [ "$CASSANDRA_LISTEN_ADDRESS" = 'auto' ]; then
	CASSANDRA_LISTEN_ADDRESS="$(hostname -i)"
fi
: ${CASSANDRA_BROADCAST_ADDRESS="$CASSANDRA_LISTEN_ADDRESS"}
if [ "$CASSANDRA_BROADCAST_ADDRESS" = 'auto' ]; then
	CASSANDRA_BROADCAST_ADDRESS="$(hostname -i)"
fi
: ${CASSANDRA_BROADCAST_RPC_ADDRESS:=$CASSANDRA_BROADCAST_ADDRESS}
if [ -n "${CASSANDRA_NAME:+1}" ]; then
	: ${CASSANDRA_SEEDS:="cassandra"}
fi
: ${CASSANDRA_SEEDS:="$CASSANDRA_BROADCAST_ADDRESS"}

sed -ri 's/(- seeds:).*/\1 "'"$CASSANDRA_SEEDS"'"/' "$CASSANDRA_CONF/cassandra.yaml"

for yaml in \
	broadcast_address \
	broadcast_rpc_address \
	cluster_name \
	endpoint_snitch \
	listen_address \
	num_tokens \
	rpc_address \
	start_rpc \
; do
	var="CASSANDRA_${yaml^^}"
	val="${!var}"
	if [ "$val" ]; then
		sed -ri 's/^(# )?('"$yaml"':).*/\2 '"$val"'/' "$CASSANDRA_CONF/cassandra.yaml"
	fi
done

for yaml in dc rack; do
	var="CASSANDRA_${yaml^^}"
	val="${!var}"
	if [ "$val" ]; then
		sed -ri 's/^('"$yaml"'=).*/\1'"$val"'/' "$CASSANDRA_CONF/cassandra-rackdc.properties"
	fi
done

if [ "${1:0:1}" = '-' ]; then
    set -- ${DAEMON} "$@"
fi

if [ "$1" = "${DAEMON}" -a "$(id -u)" = "0" ]; then
	find . \! -user ${DAEMON_USER} -exec chown ${DAEMON_USER} '{}' +
	exec gosu ${DAEMON_USER} "$@"
fi

exec "$@"
