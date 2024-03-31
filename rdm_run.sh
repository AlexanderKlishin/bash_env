#!/bin/bash -e

#ignore errors

#LD_LIBRARY_PATH=/opt/rh/llvm-toolset-7.0/root/usr/lib64 \
rdm --daemon --allow-Werror --error-limit 1000 \
    --data-dir ~/src/rdm --log-file ~/src/rdm.log
