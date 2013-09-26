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


package PackageDeb;
use Moose;

use strict;
use warnings;

use File::Spec::Functions qw(rel2abs);
use File::Basename qw(dirname);

use lib dirname( rel2abs(__FILE__) );
use PLPDeclarations ':PLPDeclarations';




has 'name' => (
    is => 'ro',
    isa => 'Str',
    required => true,
    reader => 'getName',
    writer => 'setName',
);

has 'version' => (
    is => 'ro',
    isa => 'Str',
    reader => 'getVersion',
    writer => 'setVersion',
);

has 'arch' => (
    is => 'ro',
    isa => 'Str',
    reader => 'getArch',
    writer => 'setArch',
);

has 'description' => (
    is => 'ro',
    isa => 'Str',
    reader => 'getDescription',
    writer => 'setDescription',
);

has 'dependencies' => (
    is => 'ro',
    isa => 'Str',
    reader => 'getDependencies',
    writer => 'setDependencies',
);

#has 'addrWhereCanBeFound' => (
    #is => 'ro',
    #isa => 'Str',
    #reader => 'getAddrWhereCanBeFound',
    #writer => 'setAddrWhereCanBeFound',
#);

has 'distroNamesPoolWhereItemIsNotExist' => (
    traits  => ['Array'],
    is => 'ro',
    isa => 'ArrayRef[Str]',
    default => sub {return [];},
    reader => 'getDistroNamesPoolWhereItemIsNotExist',
    writer => 'setDistroNamesPoolWhereItemIsNotExist',
);

has 'status' => (
    is => 'ro',
    isa => 'Str',
    reader => 'getStatus',
    writer => 'setStatus',
);




# # #
 # #
# #
 #
#


sub isInListOfMissedHaveDistroName {
    my $self = shift;
    my $givenDistroName = shift;

    ($givenDistroName eq "")
        && return false;

    foreach my $singleItem (@{$self->{distroNamesPoolWhereItemIsNotExist}}) {
        ($givenDistroName eq $singleItem)
            && return true;
    }
    return false;
}


# # #
 # #
# #    Setters
 #
#


sub setDistroNamesPoolWhereItemIsNotExistFromString {
    my $self = shift;
    my $newNamesSetString = shift;
    $self->{distroNamesPoolWhereItemIsNotExist} = [];

    my @newNamesSetArray = split('\s+', $newNamesSetString);
    push(@{$self->{distroNamesPoolWhereItemIsNotExist}}, @newNamesSetArray);
}


# # #
 # #
# #    Getters
 #
#




sub getUniqueId {
    my $self = shift;
    my $uniqueId = $self->{name};
    return $uniqueId;
}

sub getDistroNamesPoolWhereItemIsNotExistAsString {
    my $self = shift;
    return join(' ', @{$self->{distroNamesPoolWhereItemIsNotExist}});
}

#sub getDistroNamesPoolWhereItemIsNotExistAsArray {
    #return @{$self->{distroNamesPoolWhereItemIsNotExist}};
#}


__PACKAGE__->meta->make_immutable();
true;

#sub isEqual {
    #use constant { true => 1, false => 0 };
    #my ( $self, $targetPack ) = @_;

    #no warnings 'uninitialized';

    #print STDERR "DEBUG:" . __FILE__ . ": " . __LINE__ . ": "
             #. "Going to compare: " . $self->{name} . "  " . $self->{version}
             #. "  vs  " . $targetPack->getName() . "  " . $targetPack->getVersion()
             #. "\n";

    #! $targetPack
        #&& return false;

    ## XXX - Arch. is not going to be compared.
    ## XXX - Description is not going to be compared.
    ## XXX - Status is not going to be compared.

    #my $foreignVersion = $targetPack->getVersion();
    #my $foreignVersionTryCutEpoch = $foreignVersion;
    #$foreignVersionTryCutEpoch =~ s/^[0-9]{0,3}://;

    #($self->{name} ne $targetPack->getName())
        #&& return undef;

    #($self->{version} ne $foreignVersion)
        #|| ($self->{version} ne $foreignVersionTryCutEpoch)
        #&& return false;

    #return true;
#}

#sub isArgumentVersionGreaterOrEqual {
    #use constant { true => 1, false => 0 };
    #my $self = shift;
    #my ($versionForeign) = @_;

    #(!defined $self->{version})
        #&& print STDERR "WARNING:" . __FILE__ . ": " . __LINE__ . ": " . "Going to compare versions, but own version is undefined." . "\n";
    #(!defined $versionForeign)
        #&& print STDERR "WARNING:" . __FILE__ . ":" . __LINE__ . ": " . "Going to compare versions, but undefined value specified as argument (foreign version)." . "\n";

    #my $commandLineDpkgCompareVersions = "dpkg --compare-versions "
                #. "'". $versionForeign . "'"
                #. " ge "
                #. "'" . $self->{version} . "'"; # See 'man dpkg' on operator 'ge' vs 'ge-nl' - empty version treatment.

    #my $dpkgFeedback = system ($commandLineDpkgCompareVersions);
    #if($dpkgFeedback == shellCmdSuccess) {
        #return true;
    #} else {
        #return false;
    #}
#}

#sub obtainAvailableInReposVersions {
    #my $self = shift;
    #my $foundPacksList = new PackagesList();
    #my $singlePackage = undef;
    #my @availableVersions = ();
    #my $commandLineAptShowVersions = "apt-show-versions --allversions --package=" . $self->{name} . " 2>/dev/null" ;

    #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": " . "Going to execute shell command: " . $commandLineAptShowVersions .  "\n";

    #my @aptShowVersionsList = qx($commandLineAptShowVersions);

    #foreach my $singleEntry (@aptShowVersionsList) {
        #chomp($singleEntry);
        #$singlePackage = PackageDeb->newFromAptShowVersionsString($singleEntry);
        #(defined $singlePackage)
            #&& push(@availableVersions, $singlePackage->getVersion());
    #}

    #return @availableVersions;
#}

#sub obtainNearestNewerAvailableInRepoVersion {
    #my $self = shift;
    #my @availableVersions = $self->obtainAvailableInReposVersions();
    #my @selectedVersions = ();
    #my $selectedNearestNewerVersion = $self->{version};

    #foreach my $singleAvailableVersion (@availableVersions) {
        #($self->isArgumentVersionGreaterOrEqual($singleAvailableVersion))
            #&& push(@selectedVersions, $singleAvailableVersion);
    #}
    #$selectedNearestNewerVersion = $self->selectMinimalVersionNumber(@selectedVersions);

    #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Versions values list, which are greater than or equal to pivot version value '" . $self->{version} . "': " . join(', ', @selectedVersions) . "\n";
    #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": As nearest minimal but newer version value selected: " . $selectedNearestNewerVersion . "\n";

    #return $selectedNearestNewerVersion;
#}

#sub obtainMaximumAvailableInRepoVersion {
    #my $self = shift;
    #my @availableVersions = $self->obtainAvailableInReposVersions();
    #my @selectedVersions = ();
    #my $selectedMaximumVersion = $self->{version};

    #foreach my $singleAvailableVersion (@availableVersions) {
        #($self->isArgumentVersionGreaterOrEqual($singleAvailableVersion))
            #&& push(@selectedVersions, $singleAvailableVersion);
    #}
    #$selectedMaximumVersion = $self->selectMaximumVersionNumber(@selectedVersions);

    #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Versions values list, which are used to compare with pivot version value '" . $self->{version} . "': " . join(', ', @selectedVersions) . "\n";
    #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Maximum version value selected: " . $selectedMaximumVersion . "\n";

    #return $selectedMaximumVersion;
#}

#sub obtainExactAvailableInRepoVersion {
    #my $self = shift;
    #my @availableVersions = $self->obtainAvailableInReposVersions();
    #my @selectedVersions = ();
    #my $selectedExactVersion = $self->{version};

##    foreach my $singleAvailableVersion (@availableVersions) {
##        ($self->isArgumentVersionGreaterOrEqual($singleAvailableVersion))
##            && push(@selectedVersions, $singleAvailableVersion);
##    }
    #$selectedExactVersion = $self->selectExactVersionNumber(@availableVersions);

    #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Versions values list, which are used while comparision with pivot version value '" . $self->{version} . "': " . join(', ', @availableVersions) . "\n";
    #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Selected version value: " . $selectedExactVersion . "\n";

    #return $selectedExactVersion;
#}
#sub obtainMinimalAvailableInRepoVersion {
    #die "ERROR:" . __FILE__ . ":" . __LINE__ . ": " . "Method is not implemented at all." . "\n";
#}

#sub selectVersionNumberInRange {
    #my $self = shift;
    #my ($comparisionDPKGOperator, @availableVersions) = @_;
    ##my @availableVersions = @_;
    #my $selectedVersion = "";

    #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Have DPKG comparision operator: " . "'" . $comparisionDPKGOperator . "'" . "\n";
    #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Pivot version " . "'" . $self->{version} . "'" . " to be  compared with: " . join(', ', @availableVersions) . "\n";

    #foreach my $singleVersion (@availableVersions) {
        #my $commandLineDpkgCompareVersions = "dpkg --compare-versions "
                #. "'". $singleVersion . "'"
                #. " " . $comparisionDPKGOperator . " "
                #. "'" . $self->{version} . "' 2>/dev/null"; # See 'man dpkg' on operator 'le' vs 'le-nl' - empty version treatment. Here need to select any NOT void version number, so need operator 'le-nl'.
        #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Going to launch shell command: " . $commandLineDpkgCompareVersions . "\n";

        #my $dpkgFeedback = system ($commandLineDpkgCompareVersions);
        #($dpkgFeedback == shellCmdSuccess)
            #&& ($selectedVersion = $singleVersion);
    #}

    #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Used DPKG operator '" . $comparisionDPKGOperator . "'.\n";
    #if((defined $selectedVersion)
            #&& ($selectedVersion !~ /^$/)) {
        #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Selected version number: '" . $selectedVersion . "'.\n";
    #} else {
        #print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Version is not selected, left empty." . "\n";
    #}

    #return $selectedVersion;
#}

#sub selectMinimalVersionNumber {
    #my $self = shift;
    #my @availableVersions = @_;
    #my $selectedVersion = undef;

    #my $comparisionDPKGOperator = "le-nl";
    #$selectedVersion = $self->selectVersionNumberInRange($comparisionDPKGOperator, @availableVersions);

##print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Have comparisionDPKGOperator: " . $comparisionDPKGOperator . "\n";
##print STDERR "DEBUG:" . __FILE__ . ":" . __LINE__ . ": Have availableVersions: " . join(', ', @availableVersions) . "\n";

    #return $selectedVersion;
#}

#sub selectExactVersionNumber {
    #my $self = shift;
    #my @availableVersions = @_;
    #my $selectedVersion = undef;

    #my $comparisionDPKGOperator = "eq";
    #$selectedVersion = $self->selectVersionNumberInRange($comparisionDPKGOperator, @availableVersions);
    #return $selectedVersion;
#}

#sub selectMaximumVersionNumber {
    #my $self = shift;
    #my @availableVersions = @_;
    #my $selectedVersion = undef;

    #my $comparisionDPKGOperator = "ge";
    #$selectedVersion = $self->selectVersionNumberInRange($comparisionDPKGOperator, @availableVersions);
    #return $selectedVersion;
#}

#sub getDPKGListHeaderAsString_dpkg_1_16_1 {
    #my $dpkgListingHeaderString_01 = "Desired=Unknown/Install/Remove/Purge/Hold";
    #my $dpkgListingHeaderString_02 = "| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend";
    #my $dpkgListingHeaderString_03 = "|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)";
    #my $dpkgListingHeaderString_04 = "||/ Name Version Description";
    #my $dpkgListingHeaderString_05 = "+++-====-=======-===========";

    #my $dpkgListingHeaderText = $dpkgListingHeaderString_01 . "\n"
            #. $dpkgListingHeaderString_02 . "\n"
            #. $dpkgListingHeaderString_03 . "\n"
            #. $dpkgListingHeaderString_04 . "\n"
            #. $dpkgListingHeaderString_05 . "\n";
    #return $dpkgListingHeaderText;
#}

#sub getAsDPKGString_dpkg_1_16_1 {
    #my( $self ) = shift;

    #my $dpkgListingString= $self->{status}
            #. " " . $self->{name}
            #. " " . $self->{version}
            #. " " . $self->{description}
            #. "\n";

    #return $dpkgListingString;
#}

#sub getAsAptShowVersionsString {
    #my( $self ) = shift;

    #my $aptShowVersionsString = $self->{name}
            #. " " . $self->{version}
            #. " " . $self->{distroNamesPoolWhereItemIsNotExist}
            #. " " . $self->{addrWhereCanBeFound};

    #return $aptShowVersionsString;
#}

#1;
