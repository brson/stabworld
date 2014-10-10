#!/bin/sh

# Extract a list of features used by git repos

dir=$1
all_features=""
for rsfile in `find $dir -name "*.rs"`
do
    feature_lines=`grep "#!\[feature" $rsfile`
    # capture only betwen ( ... )
    features=`echo "$feature_lines" | sed "s/.*(\(.*\)).*/\1/"`
    if [ "$features" != "" ]
	then
	all_features="$features, $all_features"
    fi
done

# get rid of commas
all_features=`echo "$all_features" | sed 's/, / /g'`
all_features=`echo "$all_features" | sed 's/,/ /g'`

# split into lines
all_features=`echo "$all_features" | tr " " "\n"`

# sort | uniq
all_features=`echo "$all_features" | sort | uniq`

# merge lines
all_features=`echo $all_features`

echo "$dir: $all_features"
