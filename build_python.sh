
set -exv

INSTALL_PREFIX=$(cd ~ && pwd)/python
RELEASE=2.7.9
FILE=Python-$RELEASE.tgz

[ -f Python-$RELEASE.tgz ] || wget https://www.python.org/ftp/python/$RELEASE/$FILE

DIR=$(basename $FILE .tgz)
[ -d $DIR ] || tar -xvf $FILE

cd $DIR

./configure --prefix=$INSTALL_PREFIX
make
make install

echo "Python installed to $INSTALL_PREFIX"

