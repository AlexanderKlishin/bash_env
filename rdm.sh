#!/bin/bash -e

#ignore errors
killall rdm || true

rm -rf ~/src/rdm ~/src/rdm.log

#LD_LIBRARY_PATH=/opt/rh/llvm-toolset-7/root/usr/lib64 \
rdm --daemon --allow-Werror --error-limit=1000 \
    --data-dir=~/src/rdm --log-file=~/src/rdm.log
