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

package PackListProcessor;
use Moose;

use strict;
use warnings;
use Carp qw(cluck);

use File::Spec::Functions qw(rel2abs);
use File::Basename qw(dirname);
use File::Basename qw(basename);

use lib dirname( rel2abs(__FILE__) ) . "/" . "lib";
use PLPDeclarations ':PLPDeclarations';
use PackListProcessorDoc;
use PackListProcessorCLIOptions;
use ProgramsInfoFile;




has 'cliOptions' => (
    is => 'ro',
    isa => 'PackListProcessorCLIOptions',
    default => sub {return PackListProcessorCLIOptions->new_with_options();}
);

has 'nameFileWithPacksDescription' => (
    is => 'rw',
    isa => 'Str',
    default => sub {return "";},
);

has 'wantedDistributionName' => (
    is => 'rw',
    isa => 'Str',
    default => sub {return "";},
);




# # #
 # #
# #
 #
#




sub showPacksInstallCommand {
    my $self = shift;

    my $programsInfoFile = ProgramsInfoFile->new(nameFileWithList => $self->{nameFileWithPacksDescription});
    $programsInfoFile->generatePackagesListFromFileStrings();

    my @arrayNamesListedInPrgInfoFile
        = $programsInfoFile->getListedPackagesNamesAsArrayForDistro($self->{wantedDistributionName});

    print STDERR "\n";
    print STDOUT "apt-get  --dry-run  install  " . join(' ', @arrayNamesListedInPrgInfoFile) . "\n";
    print STDERR "\n";
}




# # #
 # #
# #
 #
#




sub BUILD {
    my $self = shift;

    if($self->{cliOptions}->isSomeDocRequested()) {
        PackListProcessorDoc::printoutDoc();
        exit shellCmdSuccess;
    }

    $self->{nameFileWithPacksDescription} = $self->{cliOptions}->getNameFileWithPacksDescription();
    $self->{wantedDistributionName} = $self->{cliOptions}->getWantedDistributionName();
}




__PACKAGE__->meta->make_immutable();
true;
