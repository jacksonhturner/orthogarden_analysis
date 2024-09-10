#!/usr/bin/env python3

"""
This script checks the names from two input newick-formatted trees and
reports back the shared and private values of each

stdin:
    1 - tree input A
    2 - tree input B
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


def print_not_found(names_ls_a, names_ls_b):
    a_only = [i for i in names_ls_a if i not in names_ls_b]
    b_only = [i for i in names_ls_b if i not in names_ls_a]
    print("tree 1 has the following private names:")
    print(a_only)
    print("tree 2 has the following private names:")
    print(b_only)


def main():
    with open(sys.argv[1]) as f:
        tree_a = f.read()

    with open(sys.argv[2]) as f:
        tree_b = f.read()

    names_ls_a = get_newick_names(tree_a)
    names_ls_b = get_newick_names(tree_b)
    print_not_found(names_ls_a, names_ls_b)


if __name__ == "__main__":
    main()
