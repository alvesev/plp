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

        --distro-name="Distro-Name"

            If Distro-Name is specified, a packages lists, marked as not found in this distribution, are excluded from output.

        --file="/name/for/a/file/with/packages/names/list"

            A file, to be used as software packages list.

        --help

            Show some descriptive text.

PACKAGES LIST FILE FORMAT

    A file, to be used as software packages list, for each package list must have line like:


        # head-package-name pack-name-1 pack-name-2 ,, Distro-Name-1 Distro-Name-2 ,, Distro-Version-1 Distro-Version-2 ,, Descriptive text.


    In any case, valid packages list line must be started from "# ", consists of four fields and must have three separtors " ,, " between the fields. If trailing field (description text) is left empty, the line must have trailing space as a part of the separator. The fields are: 1 - space separated packages names, 2 - space separated distributions names (where first to be mentioned package can not be found), 3 - space separated the distributions versions, 4 - any text as description.

    It is possible to specify several packages names. The first one is threated specially. Some actions will take into consideration only the heading package.

    It possible to specify several space separated distributions names. These names are names of a distributions where the heading package can NOT be found. It is possible to left this field empty.

    It possible to specify several space separated distributions versions. These versions are versions of a distributions where the heading package can NOT be found. It is possible to left this field empty. This list corresponds to list of distribution names. Processing of this field is not implemented.

    Descriptive text may be left empty.

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
