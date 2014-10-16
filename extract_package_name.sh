#!/bin/sh

# Extracts the cargo package name from a repo

dir=$1
if [ ! -f $dir/Cargo.toml ]
then
    echo "$dir: [no Cargo.toml]"
    exit 1
fi

nameline=`grep 'name.*=' $dir/Cargo.toml`
# There may be multiple names, the first one is likely the package name
nameline=`echo "$nameline" | head -n1`
name=`echo "$nameline" | sed 's/.*"\(.*\)".*/\1/'`
echo "$dir: $name"
