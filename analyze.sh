#!/bin/sh

# Analyzes the output of extract_features_from_world.sh

feature_file=$1

features=`cat $1`

total_repos=`echo "$features" | wc -l`

repos_using_features=`echo "$features" | sed '/^.*: $/d' | wc -l`
repos_not_using_features=$((total_repos - repos_using_features))
repos_using_macro_rules=`echo "$features" | grep macro_rules | wc -l`
repos_using_globs=`echo "$features" | grep globs | wc -l`
repos_not_using_only_macro_rules_or_nothing=`echo "$features" | sed 's/ macro_rules//' | sed '/^.*: *$/d' | wc -l`
repos_using_only_macro_rules_or_nothing=$((total_repos - repos_not_using_only_macro_rules_or_nothing))
repos_not_using_only_macro_rules_globs_or_nothing=`echo "$features" | sed 's/ macro_rules//' | sed 's/ globs//' | sed '/^.*: *$/d' | wc -l`
repos_using_only_macro_rules_globs_or_nothing=$((total_repos - repos_not_using_only_macro_rules_globs_or_nothing))

echo

echo "repos analyzed: $total_repos"
echo "repos using features: $repos_using_features"
echo "repos using macro rules: $repos_using_macro_rules"
echo "repos using globs: $repos_using_globs"
echo "repos using no features: $repos_not_using_features"
echo "repos using only macro_rules or nothing: $repos_using_only_macro_rules_or_nothing"
echo "repos using only macro_rules, globs or nothing: $repos_using_only_macro_rules_globs_or_nothing"

