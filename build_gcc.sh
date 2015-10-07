
set -exv

VER=4.8.5
INSTALL_PREFIX=/usr/local/CC/gcc-$VER

[ -f gcc-$VER.tar.bz2 ] || wget http://www.netgull.com/gcc/releases/gcc-$VER/gcc-$VER.tar.bz2
[ -f gmp-4.3.2.tar.bz2 ] || wget https://gmplib.org/download/gmp/gmp-4.3.2.tar.bz2
[ -f mpc-0.8.1.tar.gz ] || wget http://www.multiprecision.org/mpc/download/mpc-0.8.1.tar.gz
[ -f mpfr-2.4.2.tar.bz2 ] || wget http://www.mpfr.org/mpfr-2.4.2/mpfr-2.4.2.tar.bz2
[ -f cloog-0.18.1.tar.gz ] || wget ftp://gcc.gnu.org/pub/gcc/infrastructure/cloog-0.18.1.tar.gz
[ -f isl-0.12.2.tar.bz2 ] || wget ftp://gcc.gnu.org/pub/gcc/infrastructure/isl-0.12.2.tar.bz2

[ -d gcc-$VER ] || tar xf gcc-$VER.tar.bz2
[ -d gcc-$VER/gmp ] || (tar xf gmp-4.3.2.tar.bz2 && mv gmp-4.3.2 gcc-$VER/gmp)
[ -d gcc-$VER/mpc ] || (tar xf mpc-0.8.1.tar.gz && mv mpc-0.8.1 gcc-$VER/mpc)
[ -d gcc-$VER/mpfr ] || (tar xf mpfr-2.4.2.tar.bz2 && mv mpfr-2.4.2 gcc-$VER/mpfr)
[ -d gcc-$VER/cloog ] || (tar xf cloog-0.18.1.tar.gz && mv cloog-0.18.1 gcc-$VER/cloog)
[ -d gcc-$VER/isl ] || (tar xf isl-0.12.2.tar.bz2 && mv isl-0.12.2 gcc-$VER/isl)

mkdir -p gcc-src
cd gcc-src

../gcc-$VER/configure --prefix=$INSTALL_PREFIX --enable-languages=c,c++ --disable-multilib
make -j 5 $VERBOSE

# install it
sudo rm -rf $INSTALL_PREFIX
sudo make install
