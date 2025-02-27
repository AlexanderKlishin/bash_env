#!/bin/bash -e

#cd ~/src && rm -rf vim
#git clone https://github.com/vim/vim.git
#cd vim/src
#git checkout v8.1.0000

    #--enable-pythoninterp=yes --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/
./configure --with-features=huge --enable-multibyte \
    --enable-python3interp=yes --with-python3-config-dir=/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu/ \
    --enable-cscope \
    --with-local-dir=/home/aklishin/vim/ \
    --prefix=/home/aklishin/vim/
make -j 6
#sudo apt purge vim
#sudo make install
