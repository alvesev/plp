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


package ProgramsInfoFile;
use Moose;

use strict;
use warnings;
use Carp;
use Switch;

use File::Spec::Functions qw(rel2abs);
use File::Basename qw(dirname);

use lib dirname( rel2abs(__FILE__) );
use PLPDeclarations ':PLPDeclarations';
use PackageDeb;
use PackagesList;



has 'nameFileWithList' => (
    is => 'rw', # TODO - Should it be read only?
    isa => 'Str',
    required => true,
    reader => 'getFileName',
    writer => 'setFileName',
);

has 'packagesList' => (
    is => 'ro',
    isa => 'PackagesList',
    default => sub { return PackagesList->new(); },
    #reader => 'getPacksList',
    #writer => 'setPacksList',
    # TODO - redefine setter and getter, to harden read-write access?
);

sub generateFileWithPackagesList {
    my $self = shift;

    my %unblessedPacksListHashRef = %{$self->{packagesList}};
    #carp("Have: " . $self->{packagesList}->getListLength());
    #carp("Have: " . $self->{packagesList}->getPacksList()->{'pack2'}->getName());

    open(HANDLE_FILE_OUT, ">", $self->{nameFileWithList})
        or confess("Failed to open file '" . $self->{nameFileWithList} . "' to be writen.");
    foreach my $singlePackageDeb (values($self->{packagesList}->getPacksList())) {
        my $stringWithProgramsInfo = "# " . $singlePackageDeb->getName()
                            . " ,, " . $singlePackageDeb->getCodeNameOfSourceWhereCanBeFound()
                            . " ,, " . "distro-version-not-implemented"
                            . " ,, " . $singlePackageDeb->getDescription();
        print HANDLE_FILE_OUT $stringWithProgramsInfo . "\n";
    }
    close(HANDLE_FILE_OUT);
## package-excluded-from-install ,, none ,, none ,, Pack/packs to be omited.

    #foreach my $singlePackName (@packsNamesArray) {
        #my $singleDebPack = PackageDeb->new(name => $singlePackName);
        #$singleDebPack->setName($singlePackName);
        #$singleDebPack->setCodeNameOfSourceWhereCanBeFound($distroWhereItIsNotExist);
        ##$singleDebPack->set($distroVersionsWhereItIsNotExist); # XXX - Value is not used.
        #$singleDebPack->setDescription($humanDescription);

        #$self->{packagesList}->setPackInListToBe($singleDebPack);
    #}

}

sub generatePackagesListFromFileStrings {
    my $self = shift;
    my $fileName = $self->{nameFileWithList};
    $self->{packagesList} = PackagesList->new();

    my @collectedStrings = pickUpDataFromFile($fileName);

    foreach my $singleString (@collectedStrings) {
        my $delimeter = PACKS_LIST_STRING_FIELD_DELIMETER;

        my ($packsAllNamesString,
            $distroWhereItIsNotExist,
            $distroVersionsWhereItIsNotExist,
            $humanDescription) = split($delimeter, $singleString);

        my @packsNamesArray = split('\s+', $packsAllNamesString);

        (!defined $packsAllNamesString)
            && confess("Package name can not be undefined.");
        (!defined $distroWhereItIsNotExist)
            && ($distroWhereItIsNotExist = "");
        (!defined $distroVersionsWhereItIsNotExist)
            && ($distroVersionsWhereItIsNotExist = "");
        (!defined $humanDescription)
            && ($humanDescription = "");

        foreach my $singlePackName (@packsNamesArray) {
            my $singleDebPack = PackageDeb->new(name => $singlePackName);
            $singleDebPack->setName($singlePackName);
            $singleDebPack->setCodeNameOfSourceWhereCanBeFound($distroWhereItIsNotExist);
            #$singleDebPack->set($distroVersionsWhereItIsNotExist); # XXX - Value is not used.
            $singleDebPack->setDescription($humanDescription);

            $self->{packagesList}->setPackInListToBe($singleDebPack);
        }
    }
    #carp("Have items q.: " . $self->{packagesList}->getListLength());
}

sub pickUpDataFromFile {
    my $fileName = shift;

    my @collectedStrings = ();
    @collectedStrings = readBareStringsFromFile($fileName);
    @collectedStrings = reduceToWantedOnlyStringsInArray(@collectedStrings);

    return @collectedStrings;
}

sub readBareStringsFromFile {
    my $fileName = shift;
    my @collectedStrings = ();

    my $isParcingStringsFromPacksList = false;

    open(HANDLE_FILE, "<", $fileName)
        or die("Failed to open file '" . $fileName . "'.");
    while(<HANDLE_FILE>)
    {
        my $stringFromFile = $_;
        chomp($stringFromFile);

        isItListSTARTSign($stringFromFile)
            && ($isParcingStringsFromPacksList = true);
        isItListSTOPSign($stringFromFile)
            && ($isParcingStringsFromPacksList = false);
        ($isParcingStringsFromPacksList == true)
            && push(@collectedStrings, $stringFromFile);
    }
    close( HANDLE_FILE );
    return @collectedStrings;
}


sub reduceToWantedOnlyStringsInArray {
    my @inputStrings = @_;
    my @outputStrings = ();

    foreach my $singleString (@inputStrings) {
        switch($singleString) {
            case m/^#(\s{1,1})[^#]+/ { # Expression covers first three symbols in a string. It matches a string starting with '# ', with subsequent one symbol, but except pound sign '#'. The rest of the string is not evaluated.
                $singleString =~ s/^#(\s{1})//; # Strip leading '# '.
                push(@outputStrings, $singleString)
            }
            #case m/^\s*#/ { true;} # Widely used commentary string sign.
            #case m/^$/ { true;} # Just empty line.
            #else { true;} # Everything else.
        }
    }
    return @outputStrings;
}

#sub invertBool {
    #my $boolean = shift;
    #return $boolean != false ? false : true ; # Invert boolean value.
#}

sub isItListSTARTSign {
    my $input = shift;
    ($input =~ m/@{[PACKS_LIST_START_SIGN]}/)
        && return true;
    return false;
}
sub isItListSTOPSign {
    my $input = shift;
    ($input =~ m/@{[PACKS_LIST_STOP_SIGN]}/)
        && return true;
    return false;
}

#sub removeEmptyItems {
    #my @inputArray = @_;
    #my @outputArray = ();

    #foreach my $singleItem (@inputArray) {
        #($singleItem ne '')
            #&& push(@outputArray, $singleItem);
    #}
    #return @outputArray;
#}


sub cleanUp {
    die("Unimplemented function call.");
}


# # #
 # #
# #    Setters
 #
#


# # #
 # #
# #    Getters
 #
#


sub getPacksList {
    my $self = shift;
    my $outgoingList = $self->{packagesList};
    return $outgoingList;
}


__PACKAGE__->meta->make_immutable();
true;
