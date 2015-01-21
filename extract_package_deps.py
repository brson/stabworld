#!/usr/bin/env python

import os, sys, json, shutil

index_dir = sys.argv[1]

crates = []
for (dirpath, dirnames, filenames) in os.walk(index_dir):
    for filename in filenames:
        if ".git" in dirpath:
            continue
        if filename == "config.json":
            continue

        with open(os.path.join(dirpath, filename)) as f:
            revisions = []
            for line in f:
                data = json.loads(line)
                revisions += [data]

            most_recent_data = revisions[-1]
            name = most_recent_data["name"]
            deps = most_recent_data["deps"]
            if not most_recent_data["yanked"]:
                crates += [{ "name": name, "deps": deps }]

for crate in crates:
    crate_name = crate["name"]
    deps = crate["deps"]

    dep_names = ""
    for dep in deps:
        dep_names += " " + dep["name"]

    dep_names.strip()

    print crate_name + ": " + dep_names
