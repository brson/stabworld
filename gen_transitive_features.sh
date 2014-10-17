#!/bin/sh

# Combines the output of extract_deps_from_world.sh and
# extract_package_names_from_world.sh to create a list of
# package names and their deps

deps_file=$1
features_file=$2

features=`cat $features_file`

while read line; do
    package=`echo "$line" | sed "s/\(.*\):.*/\1/"`
    deps=`echo "$line" | sed "s/.*:\(.*\)/\1/"`
    # Get the features from all the deps. Note that packages are
    # listed as a dep of themselves so this pulls in the feature from
    # the root package as well
    package_features=" "
    for dep in $deps
    do
	new_features=`echo "$features" | grep "$dep:" | sed "s/.*: \(.*\)/\1/"`
	package_features="$package_features$new_features "
    done
    # split into lines
    package_features=`echo "$package_features" | tr " " "\n"`
    # sort | uniq
    package_features=`echo "$package_features" | sort | uniq`
    # merge lines
    package_features=`echo "$package_features" | tr "\n" " "`
    echo "$package:$package_features"
done <$deps_file
