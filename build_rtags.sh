
set -exv

HOME=$(cd ~ && pwd)
INSTALL_PREFIX=$HOME/rtags
GCC_HOME=$(dirname $(dirname $(which g++)))
LLVM_HOME=$HOME/llvm
[ -d $LLVM_HOME ] || LLVM_HOME=$(dirname $(dirname $(which llvm-config)))

cd rtags

git submodule init
git submodule update

cmake . -DLLVM_CONFIG=$LLVM_HOME/bin/llvm-config \
    -DCMAKE_CXX_COMPILER=$GCC_HOME/bin/g++ \
    -DCMAKE_C_COMPILER=$GCC_HOME/bin/gcc \
    -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1
make
make install
cp bin/* $INSTALL_PREFIX/bin

cd $INSTALL_PREFIX/bin
ln -s gcc-rtags-wrapper.sh g++
ln -s gcc-rtags-wrapper.sh c++
ln -s gcc-rtags-wrapper.sh gcc
ln -s gcc-rtags-wrapper.sh c

