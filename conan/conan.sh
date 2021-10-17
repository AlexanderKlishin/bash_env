#!/bin/bash -e

cd $(dirname $0)

sudo pip3 install virtualenv

virtualenv ~/conan
. ~/conan/bin/activate

pip3 install conan
conan remote clear
conan remote add arti \
      https://artifactory.nexign.com/artifactory/api/conan/conan-nwm-dev-local
#conan user -r arti Alexander.Klishin -p XXXX
