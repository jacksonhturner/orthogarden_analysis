#!/bin/bash

source .env

python3 ../scripts/combine_oma_genes.py $oma_dir diptera_minus_full_species.txt ${der_dir}/orthofinder

ln -s ${proj_dir}/results/2024_06_26_anopheles_fastq_0p9/publish/augustus/sequences/*.faa ${der_dir}/orthofinder
