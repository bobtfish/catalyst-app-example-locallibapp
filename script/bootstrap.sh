#!/bin/bash

perl -MCPAN -Mlocal::lib=--self-contained,local_lib -e'force(qw/install local::lib/)'
export PERL5LIB=
perl -MCPAN -Mlocal::lib=--self-contained,local_lib -e'force(qw/install local::lib/)'
exec script/installdeps.sh

