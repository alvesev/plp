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

package PackListProcessorDoc;

my $docText = '
NAME

        plp - process a list of software packages.

SYNOPSIS

        plp [OPTION]...

DESCRIPTION

        Maintains a list of packages to be stored in a file and a commands to install them, etc.

        --file="/name/for/a/file/with/packages/names/list"

            A file, to be used as software packages list.

        --help

            Show some descriptive text.

AUTHOR

        Written by Alex Vesev.

COPYRIGHT

        Copyright © 2013 Alex Vesev. License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>. This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.

';


# # #
 # #
# #
 #
#


sub printoutDoc {
    print STDOUT $docText;
}


true;
