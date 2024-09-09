#!/bin/bash

source .env

python3 ../scripts/combine_oma_genes.py $oma_dir drosophila_species.txt ${proj_dir}/data/derived/2024_07_18_oma_gene_orthology/orthofinder

ln -s ${proj_dir}/results/2024_06_26_anopheles_fastq_0p9/publish/augustus/sequences/*.faa ${proj_dir}/data/derived/2024_07_18_oma_gene_orthology/orthofinder
