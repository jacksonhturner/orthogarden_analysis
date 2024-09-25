"""
open an input file of OrthoFinder genes including OMA names (in1)
write out the most common OMA gene per orthogroup (in2)
"""

from collections import Counter
import sys


def find_oma_names(fields):
    oma_ls = []
    for field in fields:
        if "OMA" in field:
            oma = field.split("|")[1].replace("_", "")
            oma_ls.append(oma)

    count = Counter(oma_ls)
    return count.most_common(1)[0][0]


def main():
    with open(sys.argv[1]) as f, open(sys.argv[2], "w") as o:
        for line in f:
            fields = line.rstrip().split("\t")
            oma_name = find_oma_names(fields)[3:]
            o.write(f"{oma_name}\n")


if __name__ == "__main__":
    main()
