#!/bin/sh

# Clone all the repos on packages.txt

mkdir -p repos

for i in `cat packages.txt`
do
    d=`echo $i | sed 's/https:\/\///'`
    d=`echo $d | sed 's/\//\./g'`
    mkdir -p repos/$d
    git clone $i repos/$d --depth 1
done
