
#!/bin/bash
set -e

logger() {
  DT=$(date '+%Y/%m/%d %H:%M:%S')
  echo "$DT cleanup.sh: $1"
}

logger "Executing"

logger "Cleanup"
apt-get -qqy autoremove
apt-get -qqy clean

rm -rf /tmp/*
rm -rf /ops

logger "Completed"
