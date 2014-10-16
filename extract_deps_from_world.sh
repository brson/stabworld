#!/bin/sh

# Extracts cargo deps from a directory containing directories of repos

repo_dir=$1

for package_dir in `ls $repo_dir`
do
    deps=`sh ./extract_deps.sh $repo_dir/$package_dir`
    echo "$deps"
done
