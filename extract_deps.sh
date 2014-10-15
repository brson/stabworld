#!/bin/sh

# Extract a list of cargo deps used by a git repo

dir=$1
cd $dir
bash -c 'cargo generate-lockfile &> /dev/null'
if [ $? != 0 ]
then
    echo "$dir: [cargo generate-lockfile failed]"
    exit 1
fi

dot=`cargo dot`
if [ $? != 0 ]
then
    echo "$dir: [cargo dot failed]"
fi

# extract #[label="..." lines
label_lines=`echo "$dot" | egrep '\[label=".+"'`
# extract from inside quotes
labels=`echo "$label_lines" | sed 's/.*label="\(.*\)".*/\1/'`
# merge lines
labels=`echo $labels`
echo "$dir: $labels"
