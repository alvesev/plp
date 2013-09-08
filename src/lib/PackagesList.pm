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


package PackagesList;
use Moose;

use strict;
use warnings;
use Carp;


#use Switch;

use constant { true => 1, false => 0 };
#use constant { shellCmdSuccess => 0, shellCmdFailure => 1 };


has 'debPackagesList' => (
    is => 'ro',
    isa => 'HashRef[PackageDeb]',
    default => sub { return {}; },
    #reader => 'getPacksList',
    #writer => 'setPacksList',
);


#sub cleanUp {
    #die("Deprecated function call.")
    #my $self = shift;
    #$self->{debPackagesList} = {};
#}


# # #
 # #
# #    Setters
 #
#


sub setPackInListToBe {
    my $self = shift;
    my $incomingPack = shift;

    my $incomingUniqueId =  $incomingPack->getUniqueId();
    $self->{debPackagesList}->{$incomingUniqueId} = $incomingPack;
}


# # #
 # #
# #    Getters
 #
#


sub getListLength {
    my $self = shift;
    return scalar keys($self->{debPackagesList});
}

__PACKAGE__->meta->make_immutable();
true;
