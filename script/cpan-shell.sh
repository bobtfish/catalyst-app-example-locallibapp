#!/bin/bash

# Kill users own local::lib stone dead.
export PERL5LIB=
eval $(perl -Ilocal_lib/lib/perl5 -Mlocal::lib=--self-contained,local_lib)

perl -MCPAN -Mlocal::lib=--self-contained,local_lib -eshell

