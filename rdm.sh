#!/bin/bash -e

#ignore errors
killall rdm || true

rm -rf ~/src/rdm ~/src/rdm.log

rdm --daemon --data-dir=~/src/rdm --log-file=~/src/rdm.log

