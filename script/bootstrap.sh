#!/bin/sh

# This script installs an initial local::lib into your application directory
# named local-lib5, which automatically turns on local::lib support by default.

# Needs to be run as script/bootstrap.sh

# Will then install Module::Install, and all of your dependencies into
# the local lib directory created.

# FIXME - check that we have been run as script/bootstrap.sh here..

# Remove pre-existing lib
rm -rf local-lib5

# Do not take no for an answer.
export CATALYST_LOCAL_LIB=1

PWD=`pwd`
TARGET="$PWD/local-lib5"
LIB="$TARGET/lib/perl5"
export PERL_MM_OPT="INSTALL_BASE=$TARGET"
export PERL_MM_USE_DEFAULT="1"

# Install local::lib, force so we do it even if we have it already
perl -MCPAN -e'force(qw/install local::lib/)'

# Then force install it --self-contained to get dependencies
export PERL5LIB=
perl -I $LIB -Mlocal::lib=--self-contained,$TARGET -MCPAN -e'force(qw/install local::lib/)'

script/cpan-install.pl Module::Install
script/cpan-install.pl CPAN
# Needed if you have old old CPAN, fixed in more recent local::lib
# (>=1.004003)

# Mangle WWW::Mechanize with distroprefs, I'm sick of it failing.
perl -MCPAN -MCPAN::HandleConfig -e'CPAN::HandleConfig->load();
    mkdir $CPAN::Config->{prefs_dir} unless -d $CPAN::Config->{prefs_dir};
    open(PREFS, ">", File::Spec->catfile($CPAN::Config->{prefs_dir},
        "catalyst_local-lib-disable-mech-live.yml")) or die; 
    print PREFS qq{---
comment: "WWW-Mechanize regularly fails its live tests, turn them off."
match:
  distribution: "^PETDANCE/WWW-Mechanize-1.\\d+\\.tar\\.gz"
patches:
  - "BOBTFISH/WWW-Mechanize-1.XX-BOBTFISH-01_notests.patch.gz"
};
    close(PREFS);'

perl Makefile.PL
make installdeps

