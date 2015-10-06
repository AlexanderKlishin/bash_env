
HOME=$(cd ~ && pwd)
GCC_HOME=$(dirname $(dirname $(which g++)))

#export LD_LIBRARY_PATH=$GCC_HOME/lib64

cd rtags

git submodule init
git submodule update

cmake . -DLLVM_CONFIG=$HOME/llvm/bin/llvm-config || exit 1
make -j 5 || exit 1

cd bin
ln -s gcc-rtags-wrapper.sh g++
ln -s gcc-rtags-wrapper.sh gcc

cd ../

