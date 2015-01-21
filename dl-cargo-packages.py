#!/usr/bin/env python

import os, sys, shutil, subprocess, json

errors = 0

def run(args):
    print ' '.join(args)
    retval = subprocess.call(args)
    if retval != 0:
        print "call failed: " + str(args)
        sys.exit(1)

def run_but_ignore_errors(args):
    global errors
    print ' '.join(args)
    retval = subprocess.call(args)
    if retval != 0:
        errors += 1
        print "call failed: " + str(args)

def clone_or_update(repo, local):

    if not os.path.isdir(local):
        run(["git", "clone", "--depth", "1", repo, local])
    else:
        cwd = os.getcwd()
        os.chdir(local)
        run(["git", "checkout", "-f"])
        run(["git", "pull"])
        os.chdir(cwd)

index_dir = sys.argv[1]
crate_dir = sys.argv[2]
source_dir = sys.argv[3]

cargo_index_repo = "https://github.com/rust-lang/crates.io-index.git"
crate_server = "http://crates-io.s3-us-west-1.amazonaws.com/crates"

clone_or_update(cargo_index_repo, index_dir)

crates = []
for (dirpath, dirnames, filenames) in os.walk(index_dir):
    for filename in filenames:
        if ".git" in dirpath:
            continue
        if filename == "config.json":
            continue
        print filename
        revisions = []
        with open(os.path.join(dirpath, filename)) as f:
            for line in f:
                data = json.loads(line)
                revisions += [data]

        most_recent_data = revisions[-1]
        name = most_recent_data["name"]
        version = most_recent_data["vers"]
        yanked = most_recent_data["yanked"]
        if not most_recent_data["yanked"]:
            crates += [{ "name": name, "version": version, "yanked": yanked, "json": most_recent_data, "dirpath": dirpath }]

if not os.path.isdir(crate_dir):
    os.mkdir(crate_dir)

if not os.path.isdir(source_dir):
    os.mkdir(source_dir)

for crate in crates:
    crate_name = crate["name"]
    crate_version = crate["version"]
    yanked = crate["yanked"]
    file_name = crate_name + "-" + crate_version + ".crate"
    source_name = crate_name + "-" + crate_version
    remote_file_name = crate_server + "/" + crate_name + "/" + file_name

    cwd = os.getcwd()
    os.chdir(crate_dir)
    abs_crate_dir = os.getcwd()
    if not os.path.isfile(file_name):
        print crate_name + "-" + crate_version + " yanked: " + str(yanked)
        print crate["json"]
        print crate["dirpath"]
        run_but_ignore_errors(["curl", "-f", "-O", remote_file_name])
    else:
        print "already have " + crate_name + "-" + crate_version
    os.chdir(cwd)

    os.chdir(source_dir)
    if not os.path.isdir(source_name):
        run_but_ignore_errors(["tar", "xzf", abs_crate_dir + "/" + file_name])
    os.chdir(cwd)

print "errors: " + str(errors)
