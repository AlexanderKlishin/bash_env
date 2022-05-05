#!/bin/bash -e

cd $(dirname $0)

#curl http://repo/scripts/add-devtools-repo.sh | sh
sudo cp nx_devtools.repo /etc/yum.repos.d/
sudo cp nx_scl.repo /etc/yum.repos.d/

sudo yum install -y \
    devtoolset-10 \
    devtoolset-10-libasan-devel \
    devtoolset-10-libtsan-devel \
    llvm-toolset-10.0 \
    llvm-toolset-10.0-clang-devel \
    llvm-toolset-10.0-llvm-devel \
    devtoolset-11 \
    devtoolset-11-libasan-devel \
    devtoolset-11-libtsan-devel \
    llvm-toolset-11.0 \
    llvm-toolset-11.0-clang-devel \
    llvm-toolset-11.0-llvm-devel

