#!/bin/sh

# This script installs an initial local::lib into your application directory
# named local-lib5, which automatically turns on local::lib support by default.

# Needs to be run as script/bootstrap.sh

# Will then install Module::Install, and all of your dependencies into
# the local lib directory created.

# FIXME - check that we have been run as script/bootstrap.sh here..

rm -rf local-lib5
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

echo " *** FINISHED BUILDING local::lib "

echo " *** Installing Module::Install "

script/cpan-install.pl Module::Install

echo " *** Finished installing Module::Install"

perl Makefile.PL
make installdeps

