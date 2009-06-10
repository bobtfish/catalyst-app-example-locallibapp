#!/bin/bash

export PERL5LIB=
wget http://search.cpan.org/CPAN/authors/id/A/AP/APEIRON/local-lib-1.004001.tar.gz
tar xzf local-lib-1.004001.tar.gz
cd local-lib-1.004001

perl Makefile.PL --bootstrap=../local_lib
make test
make install
cd ..
rm -rf local-lib-1.004001* 

export PERL5LIB=
eval $(perl -Ilocal_lib/lib/perl5 -Mlocal::lib=--self-contained,local_lib)

perl -MCPAN -Mlocal::lib=--self-contained,local_lib -e'force(qw/install local::lib/)'

