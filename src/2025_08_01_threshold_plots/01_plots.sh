#!/usr/bin/env bash

eval "$(conda shell.bash hook)"
conda activate pb

source config

## anopheles from fasta assemblies, aedes annotation ref
mkdir -p $RESULTS/anopheles_fasta_aedes
python3 $SRC/scripts/off_plot.py \
--ogdir /pickett_centaur/project/orthogarden_analysis/results/2024_06_26_anopheles_fasta_1p0/work/9e/84a9856a032318e6ba74f0ed12653e/Results_Jun28 \
--outdir $RESULTS/anopheles_fasta_aedes

# anopheles from fastq data, aedes annotation ref
mkdir -p $RESULTS/anopheles_fastq_aedes
python3 $SRC/scripts/off_plot.py \
--ogdir /pickett_centaur/project/orthogarden_analysis/results/2024_06_26_anopheles_fastq_0p9/work/6f/1f363eb755a9475a9d27d03b464cb3/Results_Jul03 \
--outdir $RESULTS/anopheles_fastq_aedes

# anopheles from fasta assemblies, fly annotation ref
mkdir -p $RESULTS/anopheles_fasta_fly
python3 $SRC/scripts/off_plot.py \
--ogdir /pickett_centaur/project/orthogarden_analysis/results/2024_08_01_anopheles_fasta_fly_augustus/work/9d/189d20939fca281f97a6cd8f3494b7/Results_Aug04 \
--outdir $RESULTS/anopheles_fasta_fly

# henckelia
mkdir -p $RESULTS/henckelia
python3 $SRC/scripts/off_plot.py \
--ogdir /pickett_centaur/project/Moulton_JHT/trimming/Henckelia_OG_manuscript/orthogarden/henckelia_OG/work/9d/baa3108ccb028c005699a4b269b045/Results_Sep13 \
--outdir $RESULTS/henckelia

# yeast
mkdir -p $RESULTS/yeast
python3 $SRC/scripts/off_plot.py \
--ogdir /pickett_centaur/project/Moulton_JHT/trimming/Yeast_OG_manuscript/orthogarden_yeast/original_run_augustus/sequences/OrthoFinder/Results_Aug01_1 \
--outdir $RESULTS/yeast

