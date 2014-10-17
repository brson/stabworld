#!/bin/sh

repos=$1
data=$2

# First extract features
echo "\n# extracting features\n"
./extract_features_from_world.sh $repos | tee $data/features.txt
echo "\n# extracting deps\n"
./extract_deps_from_world.sh $repos | tee $data/deps.txt
echo "\n# extracting deps sources\n"
./extract_deps_sources_from_world.sh $repos | tee $data/deps_sources.txt
echo "\n# extracting package_names\n"
./extract_package_names_from_world.sh $repos | tee $data/package_names.txt
echo "\n# generating package features\n"
./gen_package_features.sh $data/package_names.txt $data/features.txt | tee $data/package_features.txt
echo "\n# generating package deps\n"
./gen_package_deps.sh $data/package_names.txt $data/deps.txt | tee $data/package_deps.txt
echo "\n generating transitive features\n"
./gen_transitive_features.sh $data/package_deps.txt $data/package_features.txt | tee $data/package_transitive_features.txt
echo "\n# ranking deps\n"
./rank_deps.sh $data/deps.txt | tee $data/ranked_deps.txt
echo "\n# finding new sources\n"
./find_new_sources.sh $data/deps_sources.txt | tee $data/new_sources.txt
echo "\n# analyzing features\n"
./analyze_features.sh $data/features.txt | tee $data/analysis_features.txt
echo "\n# analyzing deps\n"
./analyze_deps.sh $data/ranked_deps.txt $data/package_transitive_features.txt | tee $data/analysis_deps.txt

echo "\n# done\n"
