#!/bin/bash -e

cd $(dirname $0)

sudo yum install -y cloudcli --enablerepo openstack*
sudo pip3 install virtualenv

virtualenv ~/cloud
. ~/cloud/bin/activate
cp -f pip.conf ~/cloud/

pip3 install cloudcli
cloud create --services @services.json
