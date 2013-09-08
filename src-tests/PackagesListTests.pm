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

package PackagesListTests;

use strict;
use warnings;
use Carp;

use File::Spec::Functions qw(rel2abs);
use File::Basename qw(dirname);
#use File::Basename qw(basename);

use lib dirname( rel2abs(__FILE__) ) . "/../src/" . "lib";
use PackageDeb;
use PackagesList;

use constant { true => 1, false => 0 };
use constant { shellCmdFailure => 1, shellCmdSuccess => 0 };


# # #
 # #
# #
 #
#


sub launchTests {
    testConstruction();
    testAttributeSettersAndGetters();
    testSetPackInList();
    testMiscGetters();
}

sub testConstruction {
    my $packsList = PackagesList->new();

    my $expectedDefaultListSize = 0;
    my $obtainedListSize = $packsList->getListLength();

    ($expectedDefaultListSize != $obtainedListSize)
        && confess("Failed with test.");
}

sub testAttributeSettersAndGetters {
    return true;
}


sub testMiscGetters {
    my $singlePack = PackageDeb->new(name => "fake-name");
    my $packsList = PackagesList->new();

    $packsList->setPackInListToBe($singlePack);
    my $currentListSize = $packsList->getListLength();
    ($currentListSize != 1)
        && confess("Failed with test.");

}


sub testSetPackInList {
    my $expectedListSize = 1;
    my $packName_1 = "fake-name";
    my $packNameDuplicate = $packName_1;

    my $pack_1 = PackageDeb->new(name => $packName_1);
    my $pack_2 = PackageDeb->new(name => $packNameDuplicate);
    my $packsList = PackagesList->new();

    my $packId_1 = $pack_1->getUniqueId();
    my $packId_2 = $pack_2->getUniqueId();

    my $packNameFromListObject = undef;


    $packsList->setPackInListToBe($pack_1);

    $packNameFromListObject = $packsList->{debPackagesList}->{$packId_1}->getName();
    ($packNameFromListObject ne $packName_1)
        && confess("Failed with test.");

    $packsList->setPackInListToBe($pack_2);

    $packNameFromListObject = $packsList->{debPackagesList}->{$packId_2}->getName();
    ($packNameFromListObject ne $packNameDuplicate)
        && confess("Failed with test.");

    my $finalSizeOfList = $packsList->getListLength();
    ($finalSizeOfList != $expectedListSize)
        && confess("Failed with test.");

}

true;
