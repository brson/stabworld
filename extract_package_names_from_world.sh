#!/bin/sh

repo_dir=$1

for package_dir in `ls $repo_dir`
do
    if [ ! -d "$repo_dir/$package_dir" ]; then
	continue
    fi
    name=`sh ./extract_package_name.sh $repo_dir/$package_dir`
    echo "$name"
done
