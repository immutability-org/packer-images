#!/bin/bash
set -e

logger() {
  DT=$(date '+%Y/%m/%d %H:%M:%S')
  echo "$DT dnsmasq.sh: $1"
}

logger "Executing"

DNSLISTENADDR=$1

logger "Installing Dnsmasq for address: " $DNSLISTENADDR
apt-get -qqy update
apt-get -qqy upgrade
apt-get -qqy install dnsmasq-base dnsmasq

logger "Configuring Dnsmasq"
cat <<EOF >/etc/dnsmasq.d/consul
server=/consul/127.0.0.1#8600
listen-address=$DNSLISTENADDR
bind-interfaces
EOF

cat /etc/dnsmasq.d/consul

logger "Restarting dnsmasq"
service dnsmasq start || service dnsmasq restart

logger "Completed"
