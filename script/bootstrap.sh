#!/bin/sh

# This script installs an initial local::lib into your application directory
# named local-lib5, which automatically turns on local::lib support by default.

# Needs to be run as script/bootstrap.sh

# Will then install Module::Install, and all of your dependencies into
# the local lib directory created.

# FIXME - check that we have been run as script/bootstrap.sh here..

rm -rf local-lib5

export PERL5LIB=
export PERL_MM_OPT="INSTALL_BASE=local-lib5"
export PERL_MM_USE_DEFAULT="1"

perl -MCPAN -e'install(qw/local::lib/)'

echo " *** FINISHED BUILDING local::lib "

echo " *** Installing Module::Install "

script/cpan-install.pl Module::Install

echo " *** Finished installing Module::Install"

perl Makefile.PL
make installdeps

