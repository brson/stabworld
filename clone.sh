#!/bin/sh

# Clone all the repos on packages.txt

packages_file=$1
repo_dir=$2

mkdir -p $repo_dir

for i in `cat $packages_file`
do
    d=`echo $i | sed 's/https:\/\///'`
    d=`echo $d | sed 's/\//\./g'`
    mkdir -p $repo_dir/$d
    git clone $i $repo_dir/$d --depth 1
    if [ $? != 0 ]
    then
	(cd $repo_dir/$d && git checkout -f && git pull)
    fi
done
