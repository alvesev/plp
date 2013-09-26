#!/bin/bash

set -x
set -e

./plp --help
set +x ; echo -ne "\n\n\n\n" ; set -x

./plp                        --file="../src-tests/example-packages-list.conf"
./plp --distro-name="Ubuntu" --file="../src-tests/example-packages-list.conf"
