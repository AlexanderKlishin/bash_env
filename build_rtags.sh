#!/bin/bash -e

SH=$(cd `dirname $0` && pwd)

# check reqirements
exists_or_exit() {
    which $1 > /dev/null || { echo "$1 not installed"; exit 1; }
}
exists_or_exit g++
#exists_or_exit llvm-config
exists_or_exit cmake

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
COMMON+=" -DCMAKE_BUILD_TYPE=Release"

if [ $OS = "Ubuntu" ]; then
    cmake .. $COMMON
elif [ $OS = "RedHat7" ]; then
    if [ ! -d /opt/rh/llvm-toolset-7 ]; then
        echo "yum install llvm-toolset-7 llvm-toolset-7-clang-devel llvm-toolset-7-llvm-devel"
        echo "scl enable devtoolset-7 llvm-toolset-7"
        exit 1
    fi
    echo "build $OS with devtoolset"
    PATH=/opt/rh/llvm-toolset-7/root/usr/bin:$PATH \
    CXX=/opt/rh/llvm-toolset-7/root/usr/bin/clang++ \
    CC=/opt/rh/llvm-toolset-7/root/usr/bin/clang \
    cmake .. $COMMON -DLLVM_CONFIG=/opt/rh/llvm-toolset-7/root/bin/llvm-config
else
    if [ -z "$GCC_HOME" ]; then
        if [ -d /usr/local/CC/gcc-4.8.5 ]; then
            GCC_HOME=/usr/local/CC/gcc-4.8.5
        else
            GCC_HOME=$(dirname $(dirname $(which g++)))
        fi
    fi
    LLVM_HOME=$HOME/llvm
    [ -d $LLVM_HOME ] || LLVM_HOME=$(dirname $(dirname $(which llvm-config)))

    echo -e "Using:\n\tgcc:$GCC_HOME\n\tllvm:$LLVM_HOME"

    cmake .. -DLLVM_CONFIG=$LLVM_HOME/bin/llvm-config \
        -DCMAKE_CXX_COMPILER=$GCC_HOME/bin/clang++ \
        -DCMAKE_C_COMPILER=$GCC_HOME/bin/clang \
        $COMMON
fi

make -j 4
make install
cp bin/* $INSTALL_PREFIX/bin
cp $SH/rdm.sh $INSTALL_PREFIX/bin
#cp $SH/rc.sh $INSTALL_PREFIX/bin

cd $INSTALL_PREFIX/bin

#rm -f g++ c++ gcc c
#ln -s gcc-rtags-wrapper.sh g++
#ln -s gcc-rtags-wrapper.sh c++
#ln -s gcc-rtags-wrapper.sh gcc
#ln -s gcc-rtags-wrapper.sh cc
#ln -s gcc-rtags-wrapper.sh c

#if [ $OS = "Ubuntu" ]; then
    #:
#else
    #rm -f *.impl
    #mv rc rc.impl

    #cat << EOF > rc
##!/bin/bash -e
#LD_LIBRARY_PATH=/opt/rh/llvm-toolset-7/root/usr/lib64 ~/rtags/bin/rc.impl \$@
#EOF
        #chmod +x rc
#fi
