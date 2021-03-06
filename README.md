This is a set of shell scripts for analyzing Rust/Cargo repositories
en-masse.

# Basic usage

```
> ./dl-cargo-packages.py crates.io-index crates sources
> ./analyze.sh crates.io-index sources data
> cat data/analysis_features.txt
> cat data/analysis_deps.txt
```

# What's here?

* `dl-cargo-packages.py` Downloads and extracts the most recent
  version of all registered Cargo packages.
* `clone.sh` - Clone a list of repositories into a directory
* `extract_features.sh` - Extract the features used by a local
  repository in the form 'repo: feature*'
* `extract_features_from_world.sh` - As above but for a directory of
  local repos
* `extract_deps.sh` - Extract the package names of transitive
  dependencies used by a local cargo repository in the form 'repo:
  package*'. Requires cargo-dot[1].
* `extract_deps_from_world.sh` - As above but for a directory of local
  repos
* `extract_deps_sources.sh` - Extract the package sources of transitive
  dependencies used by a local cargo repository in the form 'repo:
  source*'. Requires cargo-dot[1].
* `extract_deps_sources_from_world.sh` - As above but for a directory
  of local repos
* `extract_package_name.sh` - Extract the cargo package name of a local
  cargo repository in the form 'repo: package'
* `extract_package_names_from_world.sh` - As above but for a directory
  of local repos
* `find_new_sources.sh` - Creates a list of source repos based
  the output of `extract_deps_sources_from_world.sh`.
* `gen_package_features.sh` - Combines the output of
  `extract_features_from_world.sh` (a list of 'repo: feature*') and
  the output of `extract_package_names_from_world.sh` (a list of
  'repo: package') to create a list of packages and the features they
  use (a list of 'package: feature*')
* `rank_deps.sh` - Ranks the most popular packages based on the
  output of `extract_deps_from_world.sh`
* `analyze_features.sh` - Does some basic analysis on feature usage
  based on the output of `extract_features_from_world.sh`
* `analyze_deps.sh` - Combines the output of
  `rank_deps.sh` with the output of `gen_package_features.sh` to create
  a list of the most popular packages along with the features they
  require


[1]: https://github.com/maxsnew/cargo-dot

# TODO

* Analyze stability
