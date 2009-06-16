#!/bin/sh

# This script installs an initial local::lib into your application directory
# named local-lib5.

# Needs to be run as script/bootstrap
# FIXME - check that here..

rm -rf local-lib5 local-lib-svn
/usr/bin/env svn export http://dev.catalyst.perl.org/repos/bast/local-lib/1.000/trunk/ local-lib-svn
cd local-lib-svn
perl Makefile.PL
rm -rf inc/.author
export PERL5LIB=
perl Makefile.PL --bootstrap=../local-lib5
make install
cd ..
rm -rf local-lib-svn

echo " *** FINISHED BUILDING local::lib "

echo " *** Installing Module::Install "

script/cpan-install.pl Module::Install

echo " *** Finished installing Module::Install"

perl Makefile.PL
make installdeps

