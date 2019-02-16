#!/bin/bash -e

SH=$(cd `dirname $0` && pwd)

# check reqirements
exists_or_exit() {
    which $1 > /dev/null || { echo "$1 not installed"; exit 1; }
}
exists_or_exit g++
exists_or_exit llvm-config
exists_or_exit cmake

HOME=$(cd ~ && pwd)
INSTALL_PREFIX=$HOME/rtags

OS=Unknown
if [ -f /etc/lsb-release ]; then
    OS=$(cat /etc/lsb-release | grep DISTRIB_ID | cut -d= -f2)
fi

cd rtags

git submodule init
git submodule update

mkdir -p build
cd build

COMMON="  -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX"
COMMON+=" -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
COMMON+=" -DCMAKE_BUILD_TYPE=RELEASE"

if [ $OS = "Ubuntu" ]; then
    cmake .. $COMMON
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

make -j 2
make install
cp bin/* $INSTALL_PREFIX/bin
cp $SH/rdm.sh $INSTALL_PREFIX/bin

cd $INSTALL_PREFIX/bin

#rm -f g++ c++ gcc c
#ln -s gcc-rtags-wrapper.sh g++
#ln -s gcc-rtags-wrapper.sh c++
#ln -s gcc-rtags-wrapper.sh gcc
#ln -s gcc-rtags-wrapper.sh cc
#ln -s gcc-rtags-wrapper.sh c

if [ $OS = "Ubuntu" ]; then
else
    if [ $GCC_HOME != /usr ]; then
        echo Create wrappers

        rm -f *.impl
        mv rc rc.impl
        mv rdm rdm.impl

        cat << EOF > rc
#!/bin/bash -e
    export LD_LIBRARY_PATH=$GCC_HOME/lib64:\$LD_LIBRARY_PATH
    ~/rtags/bin/rc.impl \$@
    EOF

        chmod +x rc

        cat << EOF > rdm
#!/bin/bash -e
    export LD_LIBRARY_PATH=$GCC_HOME/lib64:\$LD_LIBRARY_PATH
    ~/rtags/bin/rdm.impl \$@
    EOF
        chmod +x rdm
    fi
fi
