#!/bin/bash -exv

mkdir -p ~/src/gcc
cd ~/src/gcc

#VER=12.1.0
#VER=12.2.0
VER=12.3.0
#VER=13.1.0
#VER=13.2.0
INSTALL_PREFIX=/usr/local/gcc-$VER

[ -f gcc-$VER.tar.xz ] || wget http://mirror.linux-ia64.org/gnu/gcc/releases/gcc-$VER/gcc-$VER.tar.xz
[ -f gmp-6.3.0.tar.xz ] || wget https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz
[ -f mpc-1.3.1.tar.gz ] || wget https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz
[ -f mpfr-4.2.1.tar.zx ] || wget https://www.mpfr.org/mpfr-current/mpfr-4.2.1.tar.xz
#[ -f cloog-0.18.1.tar.gz ] || wget http://ftp.vim.org/languages/gcc/infrastructure/cloog-0.18.1.tar.gz
#[ -f isl-0.12.2.tar.bz2 ] || wget http://ftp.vim.org/languages/gcc/infrastructure/isl-0.12.2.tar.bz2

[ -d gcc-$VER ] || tar xf gcc-$VER.tar.xz
[ -d gcc-$VER/gmp ] || (tar xf gmp-6.3.0.tar.xz && mv gmp-6.3.0 gcc-$VER/gmp)
[ -d gcc-$VER/mpc ] || (tar xf mpc-1.3.1.tar.gz && mv mpc-1.3.1 gcc-$VER/mpc)
[ -d gcc-$VER/mpfr ] || (tar xf mpfr-4.2.1.tar.xz && mv mpfr-4.2.1 gcc-$VER/mpfr)
#[ -d gcc-$VER/cloog ] || (tar xf cloog-0.18.1.tar.gz && mv cloog-0.18.1 gcc-$VER/cloog)
#[ -d gcc-$VER/isl ] || (tar xf isl-0.12.2.tar.bz2 && mv isl-0.12.2 gcc-$VER/isl)

mkdir -p objdir && cd objdir
../gcc-$VER/configure --prefix=$INSTALL_PREFIX --enable-languages=c,c++ --disable-multilib
make -j 4 $VERBOSE

# install it
sudo rm -rf $INSTALL_PREFIX
sudo make install
