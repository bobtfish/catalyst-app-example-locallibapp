#!/bin/bash

export PERL5LIB=lib
export PERL5OPT=-Mlocal::lib=--self-contained,local-lib

exec perl $@
