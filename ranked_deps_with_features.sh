#!/bin/sh

# Combines the output of analyze_deps.sh with the output of
# gen_package_features.txt to create a ranked list of popular
# packages with the features they require

ranked_deps_file=$1
package_features_file=$2

package_features=`cat $package_features_file`

while read line; do
    name=`echo "$line" | cut -f2 -d" "`
    feature_line=`echo "$package_features" | grep "^$name:"`
    features=`echo "$feature_line" | sed "s/^.*:\(.*\)/\1/"`
    echo "$line:$features"
done <$ranked_deps_file
