#!/usr/bin/env perl

use FindBin;
BEGIN { warn "$FindBin::Bin/env"; do "$FindBin::Bin/env" or die $@ }
use CPAN;
shell;
1;

