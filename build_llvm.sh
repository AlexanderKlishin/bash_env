
HOME=$(cd ~ && pwd)
GCC_HOME=$(dirname $(dirname $(which g++)))
RELEASE=370

export PATH=$HOME/python/bin:$PATH
export LD_LIBRARY_PATH=$GCC_HOME/lib64

echo Build llvm, gcc home = $GCC_HOME

mkdir -p llvm

cd llvm

if [ ! -d "llvm_RELEASE_$RELEASE" ]; then
    svn co http://llvm.org/svn/llvm-project/llvm/tags/RELEASE_$RELEASE/final llvm_RELEASE_$RELEASE || exit 1
fi

cd "llvm_RELEASE_$RELEASE"

if [ ! -d "tools/clang" ]; then
    cd tools
    svn co http://llvm.org/svn/llvm-project/cfe/tags/RELEASE_$RELEASE/final clang || exit 1
    cd ..
fi

svn update

mkdir -p build
cd build

# build "Release" version, non release version has problem in parsing: "Leftover expressions for odr-use checking"' failed
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=$GCC_HOME/bin/g++ -DCMAKE_C_COMPILER=$GCC_HOME/bin/gcc -DGCC_INSTALL_PREFIX=$GCC_HOME -DCMAKE_INSTALL_PREFIX=$HOME/llvm || exit 1
make -j 10 || exit 1
make install || exit 1

