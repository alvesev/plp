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

package PackListProcessorCLIOptions;

use Moose;
with 'MooseX::Getopt';

use strict;
use warnings;
use Carp;

use File::Spec::Functions qw(rel2abs);
use File::Basename qw(dirname);
use File::Basename qw(basename);

use lib dirname( rel2abs(__FILE__) ) . "/" . "lib";
use PLPDeclarations ':PLPDeclarations';




has 'file' => (
    is => 'ro',
    isa => 'Str',
    default => sub {return "";},
    reader => 'getNameFileWithPacksDescription',
);

has 'distro-name' => (
    is => 'ro',
    isa => 'Str',
    default => sub {return "";},
    reader => 'getWantedDistributionName',
);

has 'show-install-cmd' => (
    is => 'ro',
    isa => 'Bool',
    reader => 'isShowInstCmdRequested',
);

has 'verbose' => (
    is => 'ro',
    isa => 'Bool',
    reader => 'isVerbose',
);

has 'help' => (
    is => 'ro',
    isa => 'Bool',
    reader => 'isSomeDocRequested',
);




# # #
 # #
# #
 #
#




sub BUILD {
    my $self = shift;

    ($self->isSomeDocRequested())
        && return true;

    (! -f $self->getNameFileWithPacksDescription())
        && confess("File '" . $self->getNameFileWithPacksDescription(). "', to be used as packages descriptions source, not found.");
}




__PACKAGE__->meta->make_immutable();
true;
