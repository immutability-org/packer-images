#!/bin/bash
set -e

logger() {
  DT=$(date '+%Y/%m/%d %H:%M:%S')
  echo "$DT keybase.sh: $1"
}

logger "Install keybase"

curl -s -O https://prerelease.keybase.io/keybase_amd64.deb
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f -y
run_keybase
rm keybase_amd64.deb

logger "Keybase installed"
