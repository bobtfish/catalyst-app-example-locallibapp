#!/bin/bash

source script/env
exec perl -MCPAN -Mlocal::lib=--self-contained,local_lib -eshell

