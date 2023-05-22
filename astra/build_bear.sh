#!/bin/bash -e

cd ~/src && rm -rf Bear

git clone https://github.com/rizsotto/Bear.git
cd Bear
git checkout 2.4.4
mkdir build && cd build && cmake .. && make
sudo make install
