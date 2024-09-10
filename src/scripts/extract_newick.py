#!/usr/bin/env python3

"""
This script takes the input of a single newick file and writes the names
as a newline text file.

stdin:
    1 - tree input
    2 - output file (e.g. .csv suffix)
"""

import json
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


def main():
    with open(sys.argv[1]) as f:
        tree = f.read()

    names_ls = get_newick_names(tree)
    names_ls.sort()

    with open(sys.argv[2], "w") as o:
        for name in names_ls:
            o.write(f"{name}\n")


if __name__ == "__main__":
    main()
