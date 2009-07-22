#!/usr/bin/env bash
exec /usr/bin/env perl -e 'use FindBin; BEGIN {do "$FindBin::Script/env" or die "no $FindBin::Script/env, err:".$@ } use CPAN; use local::lib qw(--self-contained local_lib); shell';

