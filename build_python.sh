
HOME=$(cd ~ && pwd)
GCC_HOME=$(dirname $(dirname $(which g++)))
RELEASE=2.7.9
FILE=Python-$RELEASE.tgz

if [ ! -f Python-$RELEASE.tgz ]; then
    wget https://www.python.org/ftp/python/$RELEASE/$FILE
fi

DIR=$(basename $FILE .tgz)
if [ ! -d $DIR ]; then
    tar -xvf $FILE
fi

cd $DIR

./configure --prefix=$HOMEME/python || exit 1
make || exit 1
make install || exit 1

