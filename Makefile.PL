#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use FindBin;
BEGIN {
    if (-d 'local-lib5') {
        do "$FindBin::Bin/script/env" or die $@;
    }
}
use inc::Module::Install;

name 'LocalLibApp';
all_from 'lib/LocalLibApp.pm';

requires 'local::lib' => '1.004001';
requires 'Catalyst::Runtime' => '5.80005';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
catalyst;

#install_script glob('script/*.pl');
auto_install;
WriteAll;
