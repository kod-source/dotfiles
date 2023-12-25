#!/bin/sh
set -eu

bin/init.sh
bin/mitamae local "$@" lib/recipe.rb
