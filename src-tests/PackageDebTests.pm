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

package PackageDebTests;

use strict;
use warnings;
use Carp;

use File::Spec::Functions qw(rel2abs);
use File::Basename qw(dirname);
#use File::Basename qw(basename);

use lib dirname( rel2abs(__FILE__) ) . "/../src/" . "lib";
use PackageDeb;

use constant { true => 1, false => 0 };
use constant { shellCmdFailure => 1, shellCmdSuccess => 0 };


# # #
 # #
# #
 #
#


sub launchTests {
    testAttributeSettersAndGetters();
    testGetUnuiqueId();
}


sub testAttributeSettersAndGetters {
    my $singleDebPackage = undef;

    my $name_1 = "fake-name-1";
    my $name_2 = "fake-name-2";
    $singleDebPackage = PackageDeb->new(name => $name_1);

    ($singleDebPackage->getName() ne $name_1)
        && confess("Failed with new instance initialisation and getter for a package name.");

    $singleDebPackage->setName($name_2);
    ($singleDebPackage->getName() ne $name_2)
        && confess("Failed with setter and getter for a package name.");


    my $version = "fake-value";
    $singleDebPackage->setVersion($version);
    ($singleDebPackage->getVersion() ne $version)
        && confess("Failed with test.");

    my $arch = "fake-value";
    $singleDebPackage->setArch($arch);
    ($singleDebPackage->getArch() ne $arch)
        && confess("Failed with test.");

    my $description = "fake-value";
    $singleDebPackage->setDescription($description);
    ($singleDebPackage->getDescription() ne $description)
        && confess("Failed with test.");

    my $dependencies = "fake-value";
    $singleDebPackage->setDependencies($dependencies);
    ($singleDebPackage->getDependencies() ne $dependencies)
        && confess("Failed with test.");

    my $addrWhereCanBeFound = "fake-value";
    $singleDebPackage->setAddrWhereCanBeFound($addrWhereCanBeFound);
    ($singleDebPackage->getAddrWhereCanBeFound() ne $addrWhereCanBeFound)
        && confess("Failed with test.");

    my $codeNameOfSourceWhereCanBeFound = "fake-value";
    $singleDebPackage->setCodeNameOfSourceWhereCanBeFound($codeNameOfSourceWhereCanBeFound);
    ($singleDebPackage->getCodeNameOfSourceWhereCanBeFound() ne $codeNameOfSourceWhereCanBeFound)
        && confess("Failed with test.");

    my $status = "fake-value";
    $singleDebPackage->setStatus($status);
    ($singleDebPackage->getStatus() ne $status)
        && confess("Failed with test.");
}

sub testGetUnuiqueId {
    my $name_1 = "fake-name-1";
    my $singleDebPackage = PackageDeb->new(name => $name_1);
    ($singleDebPackage->getUniqueId() ne $name_1)
        && confess("Failed with test.");
}

true;
