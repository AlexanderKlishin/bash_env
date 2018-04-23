
set -exv

# 600 version
#CMD=git clone -b release_60
#$CMD http://llvm.org/git/llvm.git

#$CMD http://llvm.org/git/clang.git             llvm/tools/clang
#$CMD http://llvm.org/git/clang-tools-extra.git llvm/tools/clang/tools/extra

#$CMD http://llvm.org/git/compiler-rt.git   llvm/projects/compiler-rt
#$CMD http://llvm.org/git/libcxx.git        llvm/projects/libcxx
#$CMD http://llvm.org/git/libcxxabi.git     llvm/projects/libcxxabi

HOME=$(cd ~ && pwd)
INSTALL_PREFIX=$HOME/llvm
GCC_HOME=$(dirname $(dirname $(which g++)))
LLVM_URL='http://llvm.org/svn/llvm-project'
RELEASE=370

export PATH=$HOME/python/bin:$PATH
export LD_LIBRARY_PATH=$GCC_HOME/lib64

echo "Build llvm, gcc home = $GCC_HOME"

mkdir -p llvm-src

cd llvm-src

[ -d $RELEASE ] || svn co $LLVM_URL/llvm/tags/RELEASE_$RELEASE/final $RELEASE

cd $RELEASE

[ -d tools/clang ] || svn co $LLVM_URL/cfe/tags/RELEASE_$RELEASE/final tools/clang

svn update

mkdir -p build
cd build

# build "Release" version, non release version has problem in parsing:
#   "Leftover expressions for odr-use checking"' failed
cmake .. -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_COMPILER=$GCC_HOME/bin/g++ \
    -DCMAKE_C_COMPILER=$GCC_HOME/bin/gcc \
    -DGCC_INSTALL_PREFIX=$GCC_HOME \
    -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX

make
make install

# according to http://clang-analyzer.llvm.org/scan-build
# scan-build has no make install
SB=../tools/clang/tools/scan-build
cp $SB/scan-build $INSTALL_PREFIX/bin
cp $SB/ccc-analyzer $INSTALL_PREFIX/bin
cp $SB/c++-analyzer $INSTALL_PREFIX/bin

echo "llvm installed to $INSTALL_PREFIX"

