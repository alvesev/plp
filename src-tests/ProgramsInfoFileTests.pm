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

package ProgramsInfoFileTests;

use strict;
use warnings;
use Carp;

use Switch;

use File::Spec::Functions qw(rel2abs);
use File::Basename qw(dirname);

use lib dirname( rel2abs(__FILE__) ) . "/../src/" . "lib";
use ProgramsInfoFile;
use PLPDeclarations ':PLPDeclarations';

use constant { NAME_FILE_TEST_EXAMPLE => "example-packages-list.conf" };
use constant { NUMBER_OF_PACKS_SETS_DESCRIBED_IN_EXAMPLE_FILE => 8 };


# # #
 # #
# #
 #
#


sub launchTests {
    testConstruction();
    testAttributeSettersAndGetters();
    testMiscGetters();
    testReadFileWithPacksListing();
    testWriteFileWithPacksListing();
}

sub testConstruction {
    my $fileName = "/tmp/ProgramsInfoFileTests.testConstruction.01.txt";
    my $packsInfoFile = ProgramsInfoFile->new(nameFileWithList => $fileName);
}

sub testAttributeSettersAndGetters {
    my $packsInfoFile = undef;

    my $fileName_1 = "/tmp/ProgramsInfoFileTests.testAttributeSettersAndGetters.01.txt";
    my $fileName_2 = "/tmp/ProgramsInfoFileTests.testAttributeSettersAndGetters.02.txt";

    $packsInfoFile = ProgramsInfoFile->new(nameFileWithList => $fileName_1);

    $packsInfoFile->setFileName($fileName_2);
    ($packsInfoFile->getFileName() ne $fileName_2)
        && carp("Failed with test.");
}


sub testMiscGetters {
    my $fileName = "/tmp/ProgramsInfoFileTests.testMiscGetters.txt";
    my $packsInfoFile = ProgramsInfoFile->new(nameFileWithList => $fileName);

    $packsInfoFile->getPackagesListsPool();
    # TODO -
}

sub testReadFileWithPacksListing {
    my $fileName = NAME_FILE_TEST_EXAMPLE;
    my $packsInfoFile = ProgramsInfoFile->new(nameFileWithList => $fileName);

    $packsInfoFile->generatePackagesListFromFileStrings();
    my $obtainedPackagesQuantity = $packsInfoFile->getPackagesListsPoolSize();
    my $expectedPackagesSetsTotalQuantity = NUMBER_OF_PACKS_SETS_DESCRIBED_IN_EXAMPLE_FILE;

    ($obtainedPackagesQuantity != $expectedPackagesSetsTotalQuantity)
        && confess("Failed with test. Obtained packages quantity '" . $obtainedPackagesQuantity . "', expected '" . $expectedPackagesSetsTotalQuantity . "'. Is example file modified without changes to the constants to be used with the test?");
}

sub testWriteFileWithPacksListing {
    my $fileNameForInput = NAME_FILE_TEST_EXAMPLE;
    my $fileNameForOutput = NAME_FILE_TEST_EXAMPLE . ".newly-auto-generated";
    my $packsInfoFile = ProgramsInfoFile->new(nameFileWithList => $fileNameForInput);

    $packsInfoFile->generatePackagesListFromFileStrings();
    $packsInfoFile->setFileName($fileNameForOutput);
    $packsInfoFile->generateFileWithPackagesList();
}

true;
