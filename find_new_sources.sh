#!/bin/sh

# Gets a list of package sources from the output of
# `extract_deps_sources_from_world.sh`

deps_file=$1
deps=`cat "$deps_file"`

# remove the key
deps=`echo "$deps" | cut -f1 -d ":" --complement`
# trim leading space
deps=`echo "$deps" | sed "s/^ *//"`
# remove the leading local repo name
deps=`echo "$deps" | sed "s/^file.* //"`
# remove the leading local repo name if it's the only thing on the line
deps=`echo "$deps" | sed "s/^file.*$//"`
# remove error lines
deps=`echo "$deps" | sed "s/\[cargo generate-lockfile failed\]//"`
# remove blank lines
deps=`echo "$deps" | sed "/^$/d"`
# remove trailing '.git' for canonicalization
deps=`echo "$deps" | sed "s/\.git$//"`
# sort and uniq
deps=`echo "$deps" | sort | uniq`

echo "$deps"
