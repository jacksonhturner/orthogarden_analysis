"""
given an unaltered OMA directory of fna and fa files, iterate over files
and create a separate entry for each species protein file (the original
files are per-gene, and this aggregates by species the sequences)
"""

import os
import sys


oma_dir = sys.argv[1]
target_file = sys.argv[2]
out_dir = sys.argv[3]


def touch_files():
    """
    get the names of the targets expected in sequence headers (target_ls)
    create a placeholder file to write to
    """
    target_ls = []
    with open(target_file) as f:
        for target in f:
            target_ls.append(target.rstrip())
            outfile = os.path.join(out_dir, f"{target.rstrip()}.faa")
            open(outfile, 'a').close()

    return target_ls


def extract_sequences(fasta, target_ls):
    seq = ""
    with open(fasta) as f:
        for line in f:
            if line.startswith(">"):
                if seq:
                    write_sequence(header, seq, outfile)
                    seq = ""
                header = line.rstrip().replace(" ", "_")
                for target in target_ls:
                    if target in header:
                        outfile = os.path.join(out_dir, f"{target.rstrip()}.faa")
            else:
                seq += line.rstrip()
    if seq:
        write_sequence(header, seq, outfile)


def write_sequence(header, seq, outfile):
    with open(outfile, 'a') as o:
        o.write(f'{header}\n')
        o.write(f'{seq}\n')


def main():
    target_ls = touch_files()
    for fasta in os.listdir(oma_dir):
        if fasta.endswith(".fa"):
            fasta = os.path.join(oma_dir, fasta)
            extract_sequences(fasta, target_ls)


if __name__ == "__main__":
    main()
