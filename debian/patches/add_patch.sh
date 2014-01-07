#!/bin/bash

set -e

patchpath=`dirname ${0}`

for hash in $@; do
    fname=`git log -1 --pretty=format:'%h_%f' ${hash}`
    git format-patch --stdout -N -1 ${hash} | sed -i 's,\( [ab]/\)open-vm-tools/,\1,' > "${fname}"
    if ! grep -q ${fname} series; then
        echo "${fname}" >> series
    fi
done

