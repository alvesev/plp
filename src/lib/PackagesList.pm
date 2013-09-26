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

use File::Spec::Functions qw(rel2abs);
use File::Basename qw(dirname);

use lib dirname( rel2abs(__FILE__) );
use PLPDeclarations ':PLPDeclarations';


has 'debPackagesList' => (
    is => 'ro',
    isa => 'HashRef[PackageDeb]',
    default => sub { return {}; },
    reader => 'getPacksList',
    writer => 'setPacksList',
);

has 'itemInsertionSerialNumbers' => (
    is => 'ro',
    isa => 'HashRef[Int]',
    default => sub { return {}; },
);


# # #
 # #
# #
 #
#


sub getMinInsertionSerialNumber {
    my $self = shift;
    my $minNumber = $self->getMaxInsertionSerialNumber();

    foreach my $singleItemUniqueId (keys($self->{itemInsertionSerialNumbers})) {
        my $itemInsertionNumber = $self->{itemInsertionSerialNumbers}->{$singleItemUniqueId};
        ($itemInsertionNumber < $minNumber)
            && ($minNumber = $itemInsertionNumber);
    }
    return $minNumber;
}

sub getMaxInsertionSerialNumber {
    my $self = shift;
    my $maxNumber = 0;

    foreach my $singleItemUniqueId (keys($self->{itemInsertionSerialNumbers})) {
        my $itemInsertionNumber = $self->{itemInsertionSerialNumbers}->{$singleItemUniqueId};
        ($itemInsertionNumber > $maxNumber)
            && ($maxNumber = $itemInsertionNumber);
    }
    return $maxNumber;
}

#sub compactItemsInsertionSerialNumbers {
#}

#sub shiftDownItemsInsertionSerialNumbers {
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

    if(!defined $self->{itemInsertionSerialNumbers}->{$incomingUniqueId}) {
        my $thisInsertionSerialNumber = $self->getMaxInsertionSerialNumber() + 1;
        $self->{itemInsertionSerialNumbers}->{$incomingUniqueId} = $thisInsertionSerialNumber;
    }
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

sub getItemWithInsertionSerialNumber() {
    my $self = shift;
    my $wantedItemSerialNumber = shift;
    my $foundItemId = undef;

    foreach my $singleItemUniqueId (keys($self->{itemInsertionSerialNumbers})) {
        my $itemInsertionNumber = $self->{itemInsertionSerialNumbers}->{$singleItemUniqueId};
        ((defined $itemInsertionNumber)
            && ($wantedItemSerialNumber == $itemInsertionNumber))
                    && ($foundItemId = $singleItemUniqueId);
    }
    return $self->{debPackagesList}->{$foundItemId};
}

sub getListedPackagesNamesAsArrayForDistro {
    my $self = shift;
    my $wantedDistoCodeName = shift;

    my @packagesNamesArray = ();

    my $maxSerialNumber = $self->getMaxInsertionSerialNumber();


    foreach my $singleNumber (1 .. $maxSerialNumber) {
        my $singlePack = $self->getItemWithInsertionSerialNumber($singleNumber);

        if((defined $singlePack) && (! $singlePack->isInListOfMissedHaveDistroName($wantedDistoCodeName))) {
            push(@packagesNamesArray, $singlePack->getName());
        }
    }
    return @packagesNamesArray;
}

__PACKAGE__->meta->make_immutable();
true;
