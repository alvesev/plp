#!/bin/bash
#
#  Copyright 2013-2017 Alex Vesev <alex.vesev@gmail.com>
#
#  This file is part of Packages List Processor - PLP.
#
#  PLP is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  PLP is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with PLP.  If not, see <http://www.gnu.org/licenses/>.
#
##

set -x
set -e

./plp --help
set +x ; echo -ne "\n\n\n\n" ; set -x

./plp --distro="Ubuntu" --version=16.04 --in="../src-tests/example-packages-list-format-v2.yaml"
./plp --distro="Ubuntu" --version=16.04 --in="../src-tests/example-packages-list-format-v2.yaml" --tags "server" "optional"
