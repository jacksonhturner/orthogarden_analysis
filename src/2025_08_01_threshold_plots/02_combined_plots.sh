#!/usr/bin/env bash

eval "$(conda shell.bash hook)"
conda activate pb

source config

python3 $SRC/scripts/off_plot_combined.py \
    --resdir $RESULTS \
    --outdir $RESULTS

