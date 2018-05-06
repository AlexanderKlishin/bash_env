set -exv

mkdir -p ~/src

CMD='git clone -b release_60'
LLVM_DIR=~/src/llvm
$CMD https://github.com/llvm-mirror/llvm.git $LLVM_DIR
$CMD https://github.com/llvm-mirror/clang.git $LLVM_DIR/tools/clang

cp llvm-6.0.0.spec $LLVM_DIR
cd $LLVM_DIR

mkdir -p llvm-src
rpmbuild -ba llvm-6.0.0.spec
