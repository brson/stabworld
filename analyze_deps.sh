#!/bin/sh

# Analyzes the output of extract_deps_from_world.sh

deps_file=$1

deps=`cat $1`

# Remove lines where cargo failed
deps=`echo "$deps" | grep -v "cargo generate-lockfile failed"`
stripped=`echo "$deps" | sed "s/^.*: //"`
# Put everything on its own line
lined=`echo "$stripped" | tr " " "\n"`
sorted=`echo "$lined" | sort | uniq -c | sort -nr`

echo
echo "# Popular libs"
echo "$sorted"
