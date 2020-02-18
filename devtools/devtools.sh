#!/bin/bash -e

cd $(dirname $0)

#curl http://repo/scripts/add-devtools-repo.sh | sh
sudo cp nx_devtools.repo /etc/yum.repos.d/
sudo cp nx_scl.repo /etc/yum.repos.d/

sudo yum install -y devtoolset-8 \
     llvm-toolset-7.0 \
     llvm-toolset-7.0-clang-devel \
     llvm-toolset-7.0-llvm-devel \
     llvm-toolset-7.0-cmake
