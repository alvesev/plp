#!/usr/bin/perl

#
#  Copyright 2013 Alex Vesev
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

package PLPDeclarations;


use base 'Exporter';




use constant { true => 1, false => 0 };

use constant { shellCmdFailure => 1, shellCmdSuccess => 0 };

use constant { PACKS_LIST_START_SIGN => "#### to be installed list start" };
use constant { PACKS_LIST_STOP_SIGN => "#### to be installed list stop" };
use constant { PACKS_LIST_STRING_FIELD_DELIMETER => ' ,, ' };



our @EXPORT_OK = (
                    'true',
                    'false',
                    'shellCmdFailure',
                    'shellCmdSuccess',
                    'PACKS_LIST_START_SIGN',
                    'PACKS_LIST_STOP_SIGN',
                    'PACKS_LIST_STRING_FIELD_DELIMETER'
                );

our %EXPORT_TAGS = ( PLPDeclarations => [
                        'true',
                        'false',
                        'shellCmdFailure',
                        'shellCmdSuccess',
                        'PACKS_LIST_START_SIGN',
                        'PACKS_LIST_STOP_SIGN',
                        'PACKS_LIST_STRING_FIELD_DELIMETER'
                    ] );


true;
