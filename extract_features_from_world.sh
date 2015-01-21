#!/bin/sh

# Extracts features from a directory containing directories of repos

repo_dir=$1

for package_dir in `ls $repo_dir`
do
    if [ ! -d "$repo_dir/$package_dir" ]; then
	continue
    fi
    features=`sh ./extract_features.sh $repo_dir/$package_dir`
    echo "$features"
done
