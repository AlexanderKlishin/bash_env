#!/bin/bash -e

SH=$(cd `dirname $0` && pwd)
cd $SH

sudo yum install cloudcli --enablerepo openstack*
sudo pip3 install virtualenv

virtualenv ~/cloud
. ~/cloud/bin/activate
cp -f pip.conf ~/cloud/

pip3 install cloudcli
cloud create --services @services.json
