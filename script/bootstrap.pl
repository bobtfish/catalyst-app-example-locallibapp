#!/usr/bin/env perl

# This script installs an initial local::lib into your application directory
# named local-lib5, which automatically turns on local::lib support by default.

# Needs to be run as script/bootstrap.pl

# Will then install Module::Install, and all of your dependencies into
# the local lib directory created.

use strict;
use warnings;

use lib;
use FindBin;
use CPAN;

# Do not take no for an answer.

$ENV{CATALYST_LOCAL_LIB}=1;

# Get the base paths and setup your %ENV

my $basedir;
if (-r "$FindBin::Bin/Makefile.PL") {
    $basedir = $FindBin::Bin;
}
elsif (-r "$FindBin::Bin/../Makefile.PL") {
    $basedir = "$FindBin::Bin/..";
}

$basedir ||= '';
my $target = "$basedir/local-lib5";
my $lib = "$target/lib/perl5";


$ENV{PERL_MM_OPT} = "INSTALL_BASE=$target";
$ENV{PERL_MM_USE_DEFAULT} = "1";

# First just force install local::lib to get it local to $target

force(qw/install local::lib/);

# Then force install it --self-contained to get dependencies

$ENV{PERL5LIB} = "";

# So we can find local::lib when fully self contained
lib->import("$target/lib/perl5");

# Sorry kane ;)
$ENV{PERL_AUTOINSTALL_PREFER_CPAN}=1;
$ENV{PERL_MM_OPT} .= " INSTALLMAN1DIR=none INSTALLMAN3DIR=none";

# Need to force File::HomeDir on the Mac
if ($^O eq "darwin") {
	force(qw/install Mac::Carbon/);
}

require local::lib;
local::lib->import( '--self-contained', $target );
force(qw/install local::lib/);

# Install the base modules

install('Module::Install');
install('YAML');
install('CPAN');
install('Module::Install::Catalyst');

# setup distroprefs
{
    # Ok, god only knows what version of CPAN we started with, so lets nuke the
    # config and try to reload it here for safety
    local %CPAN::Config;
    require CPAN::HandleConfig; # not installed till we installed CPAN (5.8.x)
    CPAN::HandleConfig->load();
    mkdir $CPAN::Config->{prefs_dir} unless -d $CPAN::Config->{prefs_dir};
    open(my $prefs, ">", File::Spec->catfile($CPAN::Config->{prefs_dir},
        "catalyst_local-lib-disable-mech-live.yml")) or die "Can't open prefs_dir: $!";

    print $prefs qq{---
comment: "WWW-Mechanize regularly fails its live tests, turn them off."
match:
  distribution: "^PETDANCE/WWW-Mechanize-1.\\d+\\.tar\\.gz"
patches:
  - "BOBTFISH/WWW-Mechanize-1.XX-BOBTFISH-01_notests.patch.gz"
};

    close($prefs);
}

print "local::lib setup, type perl Makefile.PL && make installdeps to install dependencies";

