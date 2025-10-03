#!/usr/bin/env python3
import argparse
import numpy as np
import matplotlib.pyplot as plt
import os
import polars as pl

'''
given orthofinder results, parse the orthogroups for those nearly
single-copy genes

note: naming prefix must be identical between augustus codingseq files
      and the .faa sequences used by OrthoFinder

overview:
[ ] open count_by_threshold files given results_dir
'''

def parse_user_input():
    parser = argparse.ArgumentParser(description='')

    parser.add_argument('-d', '--resdir', type=str, required=True,
                        help='results directory of off_plots')

    parser.add_argument('-o', '--outdir', type=str, required=True,
                        help='directory for output')

    args = parser.parse_args()

    return args


def find_count_files(args):
    df = pl.DataFrame()
    counter = 0
    names_dt = {"anopheles_fasta_aedes": "Anopheles - assemblies  (annotation: 'aedes')",
                "anopheles_fastq_aedes": "Anopheles - short reads (annotation: 'aedes')",
                "anopheles_fasta_fly":   "Anopheles - assemblies  (annotation: 'fly')",
                "henckelia":             "Henckelia - short reads",
                "yeast":                 "Yeast     - short reads"}

    color_ls = ["red", "pink", "orange", "green", "black"]
    max = 4000

    plt.figure(figsize=(10, 10), dpi=300)
    # plt.axvline(x=max, color='lightgrey', linestyle='--', linewidth=1, alpha=0.8)
    plt.axvline(x=max, color='lightgrey', linewidth=1, alpha=0.8)

    for i in os.listdir(args.resdir):
        this_thing = os.path.join(args.resdir, i)
        if os.path.isdir(this_thing):
            count_file = os.path.join(this_thing, "count_by_threshold.csv")
            tmp_df = pl.read_csv(count_file, has_header=True)
            count_ls = tmp_df["count"].to_list()
            thresh_ls = tmp_df["scg_threshold"].to_list()
            thresh_ls = [i*100 for i in thresh_ls]
            yint = np.interp(max, count_ls, thresh_ls)
            plt.hlines(yint, -100, max, colors=color_ls[counter], linestyles='--', linewidth=1, alpha=0.6)
            plt.plot(count_ls, thresh_ls, linewidth=2, label=names_dt[i], color=color_ls[counter])
            counter += 1

    plt.xlabel('Number of Orthogroups')
    plt.ylabel('% Samples with Single Gene in Orthogroup')
    # plt.xlim(0, 15000)
    plt.xlim(-100, 15000)
    # plt.xscale('log')
    plt.legend(prop={'family': 'monospace', 'size': 9})
    plt.savefig(os.path.join(args.outdir, "scg_plot_combined.png"))


def main():
    args = parse_user_input()
    find_count_files(args)


if __name__ == "__main__":
    main()

