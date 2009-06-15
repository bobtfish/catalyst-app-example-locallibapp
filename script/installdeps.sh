#!/bin/bash

echo "NOTE - THIS SCRIPT *DOES NOT* do --self_contained correctly"

export PERL5LIB=
eval $(perl -Ilocal_lib/lib/perl5 -Mlocal::lib=--self-contained,local_lib)

make installdeps

