#!/bin/bash
set -e

logger() {
  DT=$(date '+%Y/%m/%d %H:%M:%S')
  echo "$DT dependencies.sh: $1"
}

logger "Executing"

logger "Install dependencies"
apt-get -y update
apt-get -y install curl unzip wget git jq curl nginx nginx-extras apache2-utils libappindicator1
apt-get upgrade -y
apt-get dist-upgrade -y

apt-get -y install build-essential checkinstall ksh git unzip awscli
#for some reason this just won't be quiet. Maybe a vagrant thing.
apt-get -y install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
cd /usr/src
wget --progress=bar:force https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz

echo -e "\n[python] untar...\n";

tar xzf Python-2.7.12.tgz
cd Python-2.7.12

echo -e "\n[python] configure...\n";

./configure > /tmp/python-configure.log 2>&1

echo -e "\n[python] compiling...\n";

make install > /tmp/python-make-install.log 2>&1
wget --progress=bar:force https://bootstrap.pypa.io/get-pip.py

echo -e "\n[python] get-pip bootstrap...\n";

python get-pip.py > /tmp/get-pip.log 2>&1

echo -e "\n[python] pip and other stuff...\n";

pip install --quiet --upgrade pip
pip install --quiet --upgrade virtualenv


logger "Completed"
