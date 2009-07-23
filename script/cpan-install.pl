#!/usr/bin/env perl

use FindBin;
BEGIN { do "$FindBin::Bin/env" or die $@ }
use CPAN;
install(@ARGV);

1;

