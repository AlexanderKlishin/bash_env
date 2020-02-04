#!/bin/bash -e

cd $(dirname $0)

sudo cp nx_devtools.repo /etc/yum.repos.d/
sudo cp nx_scl.repo /etc/yum.repos.d/

sudo yum install devtoolset-8 llvm-toolset-7-*
