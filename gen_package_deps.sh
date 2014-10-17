#!/bin/sh

# Combines the output of extract_deps_from_world.sh and
# extract_package_names_from_world.sh to create a list of
# package names and their deps

package_names_file=$1
deps_file=$2

package_names=`cat $package_names_file`

while read line; do
    repo=`echo "$line" | sed "s/\(.*\):.*/\1/"`
    deps=`echo "$line" | sed "s/.*:\(.*\)/\1/"`
    deps=`echo "$deps" | sed "s/^ //"`
    package_name=`echo "$package_names" | grep "$repo:" | sed "s/.*: \(.*\)/\1/"`
    echo "$package_name: $deps"
done <$deps_file
