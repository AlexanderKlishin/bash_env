#!/bin/bash -e

SH=$(cd `dirname $0` && pwd)
cd $SH

sudo pip3 install virtualenv

virtualenv ~/conan
. ~/conan/bin/activate

pip3 install conan
conan remote remove conan-center
conan remote add arti \
      https://artifactory.billing.ru/artifactory/api/conan/conan-nwm-dev-local
#conan user -r arti Alexander.Klishin -p XXXX
