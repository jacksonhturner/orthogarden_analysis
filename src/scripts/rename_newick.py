#!/usr/bin/env python3

"""
This script is intended to rename entries in a newick file using a json
of stored key-value pairs

stdin:
    1 - json (or csv) to use
    2 - tree input
    3 - name for tree output
"""

import json
import pandas as pd
import re
import sys


def get_newick_names(tree):
    names_ls = []
    tree = re.sub(r'[();]', ',', tree.rstrip())
    tree = tree.split(",")
    for i in tree:
        if i:
            j = i.split(":")
            try:
                int(j[0])
            except ValueError:
                if j[0] != "":
                    names_ls.append(j[0])
    return names_ls


def prune_names(names_ls, tree):
    new_names_ls = []
    for name in names_ls:
        if re.search(r"_\d$", name):
            new_names_ls.append(name[:-2])
            tree = tree.replace(name, name[:-2])
        else:
            new_names_ls.append(name)
    return new_names_ls, tree


def print_not_found(names_dt, names_ls):
    not_found_keys = [i for i in names_dt.keys() if i not in names_ls]
    not_found_vals = [i for i in names_ls if i not in names_dt.keys()]
    print("\nrenaming keys not found in tree:")
    print(not_found_keys)
    print("\ntree names not found in renaming keys:")
    print(not_found_vals)


def main():
    names_file = sys.argv[1]
    if names_file.endswith(".json"):
        with open(names_file, 'r') as f:
            names_dt = json.load(f)
    elif names_file.endswith(".csv"):
        df = pd.read_csv(names_file, names=["ref", "rep"], header=None)
        names_dt = {k:v for k, v in zip(df["ref"].to_list(), df["rep"].to_list())}

    with open(sys.argv[2]) as f:
        tree = f.read()
    names_ls = get_newick_names(tree)
    names_ls, tree = prune_names(names_ls, tree)
    print_not_found(names_dt, names_ls)

    sorted_keys = sorted(names_dt.keys(), reverse=True)
    names_dt = {key: names_dt[key] for key in sorted_keys}
    for key, value in names_dt.items():
        tree = tree.replace(key, value)

    with open(sys.argv[3], "w") as o:
        o.write(tree)


if __name__ == "__main__":
    main()
