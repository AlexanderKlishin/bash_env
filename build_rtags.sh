#!/bin/bash -e

SH=$(cd `dirname $0` && pwd)

HOME=$(cd ~ && pwd)
INSTALL_PREFIX=$HOME/rtags

OS=Unknown
if [ -f /etc/lsb-release ]; then
    OS=$(cat /etc/lsb-release | grep DISTRIB_ID | cut -d= -f2)
elif [ -f /etc/redhat-release ]; then
    OS="RedHat"$(rpm --eval "%{dist}" | sed 's|.el||')
fi

cd $SH/rtags

git submodule init
git submodule update

mkdir -p build
cd build

COMMON="  -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX"
COMMON+=" -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
COMMON+=" -DCMAKE_BUILD_TYPE=RelWithDebInfo"

if [ $OS = "Ubuntu" ]; then
    cmake .. $COMMON
elif [ $OS = "RedHat7_9" ]; then
    CLANGVER=$(clang++ --version | grep clang | cut -d " " -f 3 | cut -d "." -f 1)
    if [ "$CLANGVER" -lt 10 ]; then
        echo "clang++ must be >= 10, current: $CLANGVER"
        exit 1
    fi
    if [ ! -d /opt/rh/llvm-toolset-11.0 ]; then
        echo "yum install llvm-toolset-11.0 llvm-toolset-11-clang-devel llvm-toolset-11-llvm-devel devtoolset-9"
        echo "scl enable devtoolset-11 llvm-toolset-11"
        exit 1
    fi
    echo "build $OS with devtoolset"
    PATH=/opt/rh/llvm-toolset-11.0/root/usr/bin:$PATH \
    CXX=/opt/rh/llvm-toolset-11.0/root/usr/bin/clang++ \
    CC=/opt/rh/llvm-toolset-11.0/root/usr/bin/clang \
    /usr/bin/cmake3 .. $COMMON
else
    echo "build $OS not supported"
fi

make -j 8
make install
cp bin/* $INSTALL_PREFIX/bin
cp $SH/rdm.sh $INSTALL_PREFIX/bin
